from flask import Blueprint, request, jsonify, make_response
import json
from src import db


customers = Blueprint('managers', __name__)

@managers.route()