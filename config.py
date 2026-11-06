class Config:
    SECRET_KEY ='mandarinassinh'
    DEBUG      =True
    
class DevelopmentConfig(Config):
    MYSQL_HOST   ='localhost'
    MYSQL_USER  ='root'
    MYSQL_PASSWORD  =''
    MYSQL_DB    ='lumen'

config = {
    'development':DevelopmentConfig
}