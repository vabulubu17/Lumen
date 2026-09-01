const header = document.querySelector("#site-header");
const menuToggle = document.querySelector(".menu-toggle");
const navMenu = document.querySelector("#primary-menu");
const cartCount = document.querySelector(".cart-count");
const toast = document.querySelector(".toast");
const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

let cartItems = 0;
let toastTimer;

function showToast(message) {
  toast.textContent = message;
  toast.classList.add("show");
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => toast.classList.remove("show"), 2800);
}

window.addEventListener("scroll", () => {
  header.classList.toggle("scrolled", window.scrollY > 18);
}, { passive: true });

menuToggle?.addEventListener("click", () => {
  const isOpen = navMenu.classList.toggle("open");
  menuToggle.setAttribute("aria-expanded", String(isOpen));
  menuToggle.setAttribute("aria-label", isOpen ? "Cerrar menú" : "Abrir menú");
});

navMenu?.querySelectorAll("a").forEach(link => {
  link.addEventListener("click", () => {
    navMenu.classList.remove("open");
    menuToggle?.setAttribute("aria-expanded", "false");
  });
});

/* Reveal on scroll */
if ("IntersectionObserver" in window && !reducedMotion) {
  const observer = new IntersectionObserver((entries, obs) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add("is-visible");
        obs.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12 });

  document.querySelectorAll(".reveal").forEach((element, index) => {
    element.style.transitionDelay = `${Math.min(index * 45, 280)}ms`;
    observer.observe(element);
  });
} else {
  document.querySelectorAll(".reveal").forEach(element => element.classList.add("is-visible"));
}

/* Cart */
function addToCart(button) {
  cartItems += 1;
  cartCount.textContent = cartItems;
  button.textContent = "Añadido ✓";
  button.disabled = true;
  showToast("El libro fue añadido a tu biblioteca.");
  setTimeout(() => {
    button.textContent = "Agregar al carrito";
    button.disabled = false;
  }, 1500);
}

document.querySelectorAll(".add-cart").forEach(button => {
  button.addEventListener("click", () => addToCart(button));
});

/* Orbit */
const orbitScene = document.querySelector(".orbit-scene");
const orbitBooks = [...document.querySelectorAll(".orbit-book")];
const orbitControl = document.querySelector("#orbit-control");
const bookDialog = document.querySelector("#book-dialog");
const dialogTitle = document.querySelector("#dialog-title");
const dialogClose = document.querySelector(".dialog-close");
const dialogAdd = document.querySelector(".dialog-add");

let orbitPaused = reducedMotion;
let orbitAngle = 0;
let lastFrame = performance.now();
let activeBookName = "";

function animateOrbit(now) {
  const delta = Math.min(now - lastFrame, 40);
  lastFrame = now;

  if (!orbitPaused) {
    orbitAngle += delta * 0.018;
    orbitBooks.forEach((book, index) => {
      const offset = index * 90;
      const localAngle = (orbitAngle + offset) * Math.PI / 180;
      const x = Math.cos(localAngle) * 10;
      const y = Math.sin(localAngle) * 5;
      const scale = 1 + Math.sin(localAngle) * 0.025;
      book.style.translate = `${x}px ${y}px`;
      book.style.scale = scale;
    });
  }

  requestAnimationFrame(animateOrbit);
}

function setOrbitState(paused) {
  orbitPaused = paused;
  orbitControl.textContent = paused ? "Reanudar órbita" : "Pausar órbita";
  orbitControl.setAttribute("aria-pressed", String(paused));
}

if (orbitControl) {
  setOrbitState(reducedMotion);
  orbitControl.addEventListener("click", () => setOrbitState(!orbitPaused));
}

orbitScene?.addEventListener("mouseenter", () => {
  if (!reducedMotion) orbitPaused = true;
});
orbitScene?.addEventListener("mouseleave", () => {
  if (orbitControl?.getAttribute("aria-pressed") !== "true" && !reducedMotion) orbitPaused = false;
});

orbitBooks.forEach(book => {
  book.addEventListener("click", () => {
    const name = book.dataset.book || "Historia Lumen";
    activeBookName = name;
    dialogTitle.textContent = name;
    book.classList.remove("spin-once");
    void book.offsetWidth;
    book.classList.add("spin-once");

    if (typeof bookDialog.showModal === "function") {
      bookDialog.showModal();
    } else {
      showToast(name);
    }
  });
});

dialogClose?.addEventListener("click", () => bookDialog.close());
bookDialog?.addEventListener("click", event => {
  if (event.target === bookDialog) bookDialog.close();
});
dialogAdd?.addEventListener("click", () => {
  cartItems += 1;
  cartCount.textContent = cartItems;
  showToast(`“${activeBookName}” fue añadido a tu biblioteca.`);
  bookDialog.close();
});

if (!reducedMotion) requestAnimationFrame(animateOrbit);

/* Newsletter */
const newsletterForm = document.querySelector("#newsletter-form");
newsletterForm?.addEventListener("submit", event => {
  event.preventDefault();
  const email = document.querySelector("#email");

  if (!email.value || !email.validity.valid) {
    email.focus();
    showToast("Escribe un correo electrónico válido.");
    return;
  }

  showToast("¡Bienvenido a Lumen! Revisa tu correo para confirmar tu suscripción.");
  newsletterForm.reset();
});

/* Utility buttons */
document.querySelector('[data-action="search"]')?.addEventListener("click", () => {
  showToast("La búsqueda estará disponible muy pronto.");
});
document.querySelector('[data-action="favorites"]')?.addEventListener("click", () => {
  showToast("Guarda tus historias favoritas para volver a ellas.");
});
document.querySelector('[data-action="cart"]')?.addEventListener("click", () => {
  showToast(cartItems ? `Tienes ${cartItems} ${cartItems === 1 ? "libro" : "libros"} en tu carrito.` : "Tu carrito está vacío.");
});
