from flask import Flask, request, jsonify
from pyspark.sql import SparkSession
from pyspark.ml.fpm import FPGrowthModel
from pyspark.sql.functions import expr
import os

# Spark 세션 초기화
spark = SparkSession.builder.appName("Flask-CombinationRecommendation").getOrCreate()

# 모델 불러오기
model_path = "/home/ubuntu/models/"
if os.path.exists(model_path):
    print("모델 경로가 존재합니다.")
    model = FPGrowthModel.load(model_path)
else:
    print("모델 경로가 존재하지 않습니다.")
    exit()  # 모델이 없으면 서버 실행을 중단

# Flask 설정
app = Flask(__name__)

# 특정 product_id에 대한 추천 아이템 목록을 반환하는 함수
def get_recommendations_for_product(product_id, model):
    # 모델의 associationRules에서 antecedent에 product_id가 있는 규칙을 필터링
    filtered_rules = model.associationRules.filter(expr(f"array_contains(antecedent, {product_id})"))
    # 필터링된 규칙에서 consequent만 추출하여 추천 목록 생성
    recommendations = [row["consequent"] for row in filtered_rules.collect()]
    return recommendations

# 추천 로직 구현
@app.route('/recommend', methods=['GET'])
def recommend():
    product_ids_str = request.args.get('product_id', type=str)  # 문자열로 받음
    product_ids = [int(id) for id in product_ids_str.split(',')]  # 콤마로 구분된 값을 정수 리스트로 변환
    recommended_products = []

    for product_id in product_ids:
        recommendations = get_recommendations_for_product(product_id, model)
        # 중첩 배열을 단일 배열로 변환
        flat_recommendations = [item for sublist in recommendations for item in sublist]
        recommended_products.extend(flat_recommendations)


    return jsonify({"Recommended Products": recommended_products})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
