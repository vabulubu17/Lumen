class Config:
    SECRET_KEY ='mandarinassinh'
    DEBUG      =True
    
class DevelopmentConfig(Config):
    MSQL_HOST   ='localhost'
    MYSQL_USER  ='root'
    MYSQL_PASSWORD  ='mysql'
    MYSQL_DB    ='lumen'

config = {
    'development':DevelopmentConfig
}