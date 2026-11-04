from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from config import config
from werkzeug.security import generate_password_hash
from models.entities.User import User
from models.ModelUser import ModelUser

lumenApp    =Flask(__name__)
lumenApp.config.from_object(config['development'])
db          = MySQL(lumenApp)
adminUsuarios = LoginManager (lumenApp)

@adminUsuarios.user_loader
def agregarUsuario(id):
    return ModelUser.get_by_id(db,id)

@lumenApp.route('/')
def home():
    return render_template('home.html')

@lumenApp.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method =='POST':
        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form['clave']
        claveCifrada = generate_password_hash(clave)
        regUsuario = db.connection.cursor()
        regUsuario.execute("INSERT INTO usuario (nombre, correo, clave, perfil) VALUES (%s, %s, %s, %s)", (nombre, correo, claveCifrada, 'U'))
        db.connection.commit()
        regUsuario.close()
        return redirect(url_for('home'))

    return redirect(url_for('home'))

@lumenApp.route('/signin', methods = ['GET', 'POST'])
def signin():
    if request.method == 'POST':
        usuario = User(0, None, request.form['correo'], request.form['clave'], None)
        usuarioAutenticado = ModelUser.signin(db, usuario)
        if usuarioAutenticado is not None:
            if usuarioAutenticado.clave:
                login_user(usuarioAutenticado)
                if usuarioAutenticado.perfil == 'A':
                    return redirect(url_for('home_admin'))
                else:
                    return redirect(url_for('home_user'))
            else:
                flash('contraseña incorrecta')
                redirect(url_for('home'))
        else:
            flash('Usuario inexistente')
            redirect(url_for('home'))
    else:
        render_template('home.html')

@lumenApp.route('/signout', methods = ['GET', 'POST'])
def signout():
    logout_user()
    return redirect(url_for('home'))

@lumenApp.route ('/home_admin', methods = ['GET', 'POST'])
@login_required
def home_admin ():
    return render_template ('admin.html')

@lumenApp.route ('/home_user', methods = ['GET', 'POST'])
@login_required
def home_user ():
    return render_template ('user.html')

@lumenApp.route ('/sUsuario', methods = ['GET', 'POST'])
@login_required
def sUsuario ():
    return render_template ('users.html')

if __name__ == '__main__':
    lumenApp.run(debug=True, port=1703)