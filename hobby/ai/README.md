# Hobby AI/ML Template

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

A lightweight template for building simple ML projects and experiments. Perfect for learning, prototyping, and deploying small ML models.

---

## Quick Start

```bash
# 1. Read the context
cat docs/01-context.md

# 2. Set up development
cat docs/02-dev_protocol.md

# 3. Understand requirements
cat docs/03-product_requirements.md

# 4. Start experimenting!
```

---

## Stack Recommendations

### For Simple Projects
- **Python:** 3.10+
- **Libraries:** scikit-learn, pandas
- **Deployment:** Streamlit/Gradio
- **Hosting:** Hugging Face Spaces (free)

### For Deep Learning
- **Framework:** PyTorch/TensorFlow
- **Notebook:** Jupyter/Google Colab (free GPU)
- **Deployment:** Hugging Face Inference API (free tier)

---

## What You Get

- **Minimal setup** - Start with Jupyter notebook
- **Free compute** - Google Colab GPU
- **Simple deployment** - Streamlit/Gradio
- **Free hosting** - Hugging Face Spaces

---

## Example: Text Classifier

### Features
1. Train on custom dataset
2. Simple web interface (Gradio)
3. Free deployment

### Setup (10 minutes)
```bash
# 1. Create project
mkdir my-classifier && cd my-classifier

# 2. Install dependencies
pip install scikit-learn pandas gradio

# 3. Create app.py (see example below)
# 4. Run locally
python app.py
```

### Code Example
```python
import gradio as gr
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB

# Train simple model
texts = ["I love this!", "This is terrible", "Pretty good"]
labels = ["positive", "negative", "positive"]

vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(texts)
model = MultinomialNB()
model.fit(X, labels)

# Prediction function
def predict(text):
    X_test = vectorizer.transform([text])
    return model.predict(X_test)[0]

# Create interface
demo = gr.Interface(
    fn=predict,
    inputs="text",
    outputs="text",
    title="Simple Text Classifier"
)

demo.launch()
```

---

## Free Tools

### Development
- **Google Colab** - Free GPU/TPU
- **Kaggle Kernels** - Free compute + datasets
- **Jupyter** - Local notebooks

### Deployment
- **Streamlit** - Simple web apps
- **Gradio** - ML interfaces
- **Hugging Face Spaces** - Free hosting

### Data
- **Kaggle** - Free datasets
- **Hugging Face Datasets** - NLP datasets
- **UCI ML Repository** - Classic datasets

---

## Deployment (Free)

### Hugging Face Spaces
```bash
# 1. Create requirements.txt
echo "gradio" > requirements.txt
echo "scikit-learn" >> requirements.txt

# 2. Create app.py (your Gradio app)

# 3. Push to Hugging Face Space
# (or use web UI to upload)
```

### Streamlit Cloud
```bash
# 1. Push code to GitHub
# 2. Connect repo to Streamlit Cloud
# 3. Deploy!
```

---

## Project Structure

```
my-ml-project/
├── docs/
│   ├── 01-context.md
│   ├── 02-dev_protocol.md
│   └── 03-product_requirements.md
├── data/              # Datasets
├── notebooks/         # Jupyter notebooks
├── app.py            # Deployment app
├── requirements.txt
└── README.md
```

---

## Documentation

- **[01-context.md](docs/01-context.md)** - Problem and goals
- **[02-dev_protocol.md](docs/02-dev_protocol.md)** - Setup guide
- **[03-product_requirements.md](docs/03-product_requirements.md)** - Requirements
- **[AGENTS.md](AGENTS.md)** - AI collaboration guide

---

## Tips for Success

1. **Start with notebooks** - Explore data in Jupyter/Colab
2. **Use simple models first** - Try scikit-learn before deep learning
3. **Deploy early** - Share with Gradio/Streamlit
4. **Use free GPU** - Google Colab for training
5. **Keep data small** - < 100MB for hobby projects

---

## Next Steps

1. Read [01-context.md](docs/01-context.md) to define your problem
2. Follow [02-dev_protocol.md](docs/02-dev_protocol.md) to set up
3. Build from [03-product_requirements.md](docs/03-product_requirements.md)
4. Deploy to Hugging Face Spaces
5. Share and iterate!

---

> **Remember:** Start simple with scikit-learn. Add deep learning only if needed. Ship fast! 🚀
