# SPM · Solicitudes (CSV)

Aplicación mínima para cargar y listar solicitudes de materiales basada en Flask (API + estáticos) y JS vanilla.

## ¿Qué cambié en esta revisión?

- **Frontend servido por Flask**: ahora `backend/app.py` expone `/` e incluye los estáticos, por lo que basta con levantar el backend y abrir <http://localhost:5000/> para usar la app.
- **API base robusta en el front**: si abrís `index.html` con doble click (`file://`), el front usará `http://localhost:5000/api`. Si lo servís desde un host/puerto, usará `ORIGIN/api`.
- **CORS para cookies**: activado para `/api/*` leyendo la env `SPM_CORS_ORIGINS` (lista separada por comas). Necesario si usás un dev server aparte.
- **Limpieza del proyecto**: se excluyó `.venv/`, `__pycache__/`, etc. en `.gitignore` para evitar problemas entre SOs y repos enormes.

## Requisitos

- Python 3.12+
- (Opcional) Docker

## Ejecución local (todo-en-uno)

```bash
# 1) Crear entorno e instalar dependencias
python -m venv .venv
. .venv/bin/activate  # En Windows: .venv\Scripts\activate
pip install -r backend/requirements.txt

# 2) Variables de entorno (opcional)
export SPM_SECRET_KEY="cambia-esto"
export SPM_CORS_ORIGINS="http://localhost:8080,http://127.0.0.1:5173"

# 3) Levantar el backend (sirve el front en /)
python backend/app.py
```

Abrí <http://localhost:5000/> en el navegador.

> **Nota**: La base `backend/data/spm.db` ya viene incluida con datos de ejemplo. Si querés regenerarla desde los CSV, borra el archivo `spm.db` y el backend la creará al iniciar.

## Docker

```bash
docker build -t spm-backend -f backend/Dockerfile .
docker run --rm -p 5000:5000 -e SPM_SECRET_KEY="cambia-esto" spm-backend
```

Abrí <http://localhost:5000/>.

Si servís el front con otro servidor, asegurate de exponer CORS:

```bash
docker run --rm -p 5000:5000 -e SPM_CORS_ORIGINS="http://localhost:8080" spm-backend
```

## Endpoints rápidos (para probar)

```bash
curl -i http://localhost:5000/api/health

# Login
curl -i -X POST http://localhost:5000/api/login \
  -H 'Content-Type: application/json' \
  -d '{"id":"usuario1","password":"changeme123"}'

# Búsqueda de materiales
curl -i 'http://localhost:5000/api/materiales?q=valvula&limit=5'
```

## Estructura

- `backend/`: Flask API, base SQLite y carga desde CSV.
- `frontend/`: `index.html` + `app.js`.
- `app/`: prototipos (FastAPI) no requeridos para usar el front.

---

Hecho con cariño y obsesión por los bordes extraños del mundo del software. :)

