from imageai.Detection import ObjectDetection
import os
from bs4 import BeautifulSoup
import requests
from app import app
from flask import Flask, request, redirect, jsonify
from werkzeug.utils import secure_filename


ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/upload', methods=['POST'])
def upload_file():
    # check if the post request has the file part
    if 'file' not in request.files:
        resp = jsonify({'message': 'No file part in the request'})
        resp.status_code = 400
        return resp
    file = request.files['file']
    if file.filename == '':
        resp = jsonify({'message': 'No file selected for uploading'})
        resp.status_code = 400
        return resp
    if file and allowed_file(file.filename):
        filename = 'test1.jpg'
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        resp = jsonify({'message': 'File successfully uploaded'})
        resp.status_code = 201
        list = ['God could not be everywhere, so he created mothers. ... A mother understands what a child does not say. ... He that would the daughter win must with the mother first begin. ... Mother is a verb, not a noun. ... An ounce of mother is worth a pound of clergy.More items...', 'suyash']
        return jsonify(list)
    else:
        resp = jsonify({'message': 'Allowed file types are txt, pdf, png, jpg, jpeg, gif'})
        resp.status_code = 400
        return resp
@app.route('/get')
def getmethod():
    list = []
    execution_path = os.getcwd()
    detector = ObjectDetection()

    detector.setModelTypeAsYOLOv3()
    detector.setModelPath( os.path.join(execution_path , "yolo.h5"))
    detector.loadModel()

    detection = detector.detectObjectsFromImage(input_image=os.path.join(execution_path,'test1.jpg'),
                                                output_image_path=os.path.join(execution_path, "detected_image"))



    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}

    for eachItem in detection:
        # print(eachItem["name"] , " : ", eachItem["percentage_probability"])
        item = eachItem["name"]
        str = "proverb on "
        search = str + item
        search = search.replace(" ", "+")
        # search = search.replace("proverb on ")
        link = "https://www.google.com/search?q="+search
        # print(link)
        source = requests.get(link).text
        source = requests.get(link, headers=headers).text
        soup = BeautifulSoup(source, "html.parser")
        # print(soup.prettify())
        try:
            answer = soup.find('span', class_="e24Kjd")

            print(answer.text)
            list.append(answer.text)

        except:
            answer = soup.find('div', class_='RqBzHd')

            print(answer.text)
            list.append(answer.text)

    # print(list)
    proverb = {
        "prob": list
    }

    return jsonify(proverb)

if __name__ == "__main__":
    app.run(port=5000)





