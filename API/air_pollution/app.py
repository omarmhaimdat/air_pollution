from flask import Flask
from flask_restful import Resource, Api
from predict import predict_pollution

app = Flask(__name__)
api = Api(app)


class PollutionPrediction(Resource):

    def get(self, date: str):
        print(date)
        prediction = predict_pollution(date)
        print(prediction)
        return {'prediction': prediction}


api.add_resource(PollutionPrediction, '/<string:date>')

if __name__ == '__main__':
    app.run(debug=True)
