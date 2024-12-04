import uvicorn

from copier_pdm_fastapi import app

if __name__ == "__main__":
    uvicorn.run("main:app", port=5000, log_level="debug", reload=True)
