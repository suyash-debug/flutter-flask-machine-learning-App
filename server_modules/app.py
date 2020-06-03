from flask import Flask
import os
from werkzeug.utils import secure_filename

UPLOAD_FOLDER = 'C:/Users/Poonam/PycharmProjects/obj2'

app = Flask(__name__)
app.secret_key = "secret key"
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024