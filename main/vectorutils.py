import numpy as np
import matplotlib.pyplot as plt


class VectorUtils:
    @staticmethod
    def cosine_similarity(vec1, vec2):
        dot_product = np.dot(vec1, vec2)
        norm_product = np.linalg.norm(vec1) * np.linalg.norm(vec2)
        return dot_product / norm_product

    @staticmethod
    def compute_similarity_matrix(vectors):
        n = len(vectors)
        similarity_matrix = np.zeros((n, n))
        for i in range(n):
            for j in range(n):
                similarity_matrix[i, j] = VectorUtils.cosine_similarity(vectors[i], vectors[j])
        return similarity_matrix
    
