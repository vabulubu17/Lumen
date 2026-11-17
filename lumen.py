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
    return render_template ('home_admin.html')

@lumenApp.route ('/home_user', methods = ['GET', 'POST'])
@login_required
def home_user ():
    return render_template ('home_user.html')

@lumenApp.route ('/sUsuario', methods = ['GET', 'POST'])
@login_required
def sUsuario ():
    if current_user.perfil == 'A':
        selUsuario = db.connection.cursor()
        selUsuario.execute("SELECT * FROM usuario")
        u = selUsuario.fetchall()
        selUsuario.close()
        return render_template('users.html', usuarios=u)
    else: 
        flash('No tiene permisos para acceder a esta página')
        return redirect(url_for('home'))

@lumenApp.route ('/uUsuario/<int:id>', methods = ['GET', 'POST'])
@login_required
def uUsuario (id):
    if current_user.perfil == 'A':
        nombre = request.form ['nombre']
        correo = request.form ['correo']
        perfil = request.form ['perfil']
        actUsuario = db.connection.cursor()
        actUsuario.execute("UPDATE usuario SET nombre = %s, correo = %s, perfil = %s WHERE id = %s", (nombre, correo, perfil, id))
        db.connection.commit ()
        actUsuario.close ()
        flash ('Registro Actualizado')
        redirect(url_for('sUsuario'))
    else:
        render_template('home.html')

@lumenApp.route ('/iUsuario', methods = ['GET', 'POST'])
@login_required
def iUsuario ():
    if current_user.perfil == 'A':
        nombre = request.form ['nombre']
        correo = request.form ['correo']
        perfil = request.form ['perfil']
        clave = request.form ['clave']
        claveCifrada = generate_password_hash(clave)
        regUsuario = db.connection.cursor()
        regUsuario.execute ("INSERT INTO usuario (nombre, correo, clave, perfil) VALUES (%s, %s, %s, %s)", (nombre, correo, claveCifrada, perfil))
        db.connection.commit()
        flash('Usuario registrado satisfactoriamente')
        regUsuario.close()
        return redirect (url_for('sUsuario'))
    else:
        return render_template('home.html')

@lumenApp.route ('/dUsuario/<int:id>', methods = ['GET', 'POST'])
@login_required
def dUsuario (id):
    if current_user.perfil == 'A':
        delUsuario = db.connection.cursor()
        delUsuario.execute ("DELETE FROM usuario WHERE id = %s", (id))
        db.connection.commit()
        delUsuario.close()
        flash ('Usuario eliminado')
    else:
        return render_template('home.html')

if __name__ == '__main__':
    lumenApp.run(debug=True, port=1703)