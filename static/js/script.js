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

/* Auth modals — solo diseño y animación de apoyo, sin lógica de autenticación real */
document.querySelectorAll(".auth-toggle-pass").forEach(toggle => {
  toggle.addEventListener("click", () => {
    const input = toggle.previousElementSibling;
    if (!input) return;
    const isVisible = input.type === "text";
    input.type = isVisible ? "password" : "text";
    toggle.setAttribute("aria-pressed", String(!isVisible));
    toggle.innerHTML = isVisible
      ? '<i class="fa-regular fa-eye"></i>'
      : '<i class="fa-regular fa-eye-slash"></i>';
  });
});

/* Cambio entre modal de login y registro */
document.querySelectorAll(".auth-switch-link").forEach(link => {
  link.addEventListener("click", () => {
    const fromId = link.dataset.switchFrom;
    const toId = link.dataset.switchTo;
    const fromModalEl = document.getElementById(fromId);
    const toModalEl = document.getElementById(toId);
    if (!fromModalEl || !toModalEl || typeof bootstrap === "undefined") return;

    const fromModal = bootstrap.Modal.getOrCreateInstance(fromModalEl);
    fromModal.hide();

    fromModalEl.addEventListener("hidden.bs.modal", () => {
      bootstrap.Modal.getOrCreateInstance(toModalEl).show();
    }, { once: true });
  });
});

/* Indicador visual de fuerza de contraseña (solo estético, sin validar seguridad real) */
const registerPassword = document.querySelector("#register-password");
const strengthBars = document.querySelectorAll(".auth-strength span");

function paintStrength(value) {
  if (!strengthBars.length) return;
  const length = value.length;
  let level = 0;
  if (length >= 1) level = 1;
  if (length >= 5) level = 2;
  if (length >= 8) level = 3;
  if (length >= 8 && /[A-Z]/.test(value) && /[0-9]/.test(value)) level = 4;

  const colors = ["var(--acento)", "var(--acento)", "#c98a1f", "var(--secundario)"];
  strengthBars.forEach((bar, index) => {
    bar.style.background = index < level ? colors[level - 1] : "";
  });
}

registerPassword?.addEventListener("input", event => paintStrength(event.target.value));

/* Los formularios se envían a Flask (/signin y /signup) */
document.querySelector("#register-form")?.addEventListener("submit", event => {
  const pass = document.querySelector("#register-password").value;
  const confirm = document.querySelector("#register-confirm").value;
  if (pass.length < 6) {
    event.preventDefault();
    showToast("La contraseña debe tener al menos 6 caracteres.");
  } else if (pass !== confirm) {
    event.preventDefault();
    showToast("Las contraseñas no coinciden.");
  }
});