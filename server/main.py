from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="CALMOS PRO API",
    version="1.0.0",
    description="Serveur officiel de l'application éducative CALMOS PRO"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def home():
    return {
        "application": "CALMOS PRO",
        "status": "online",
        "message": "Serveur CALMOS PRO opérationnel"
    }

@app.get("/health")
def health():
    return {
        "status": "healthy",
        "service": "CALMOS PRO API"
    }
