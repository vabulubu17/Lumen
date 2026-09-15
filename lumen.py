from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL
from config import config

lumenApp    =Flask(__name__)
db          = MySQL(lumenApp)

@lumenApp.route('/')

def home():
    return render_template('home.html')

if __name__ == '__main__':
    lumenApp.run(port=1703,debug=True)