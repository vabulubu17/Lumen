from flask import Flask

lumenApp    =Flask(__name__)

@lumenApp.route('/')

def home():
    return '<h1>Hello World</h1>'

if __name__ == '__main__':
    lumenApp.run(port=1703,debug=True)