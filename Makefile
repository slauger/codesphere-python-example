.PHONY: run run-backend run-frontend install install-backend install-frontend test test-backend test-frontend

install: install-backend install-frontend

install-backend:
	cd backend && uv sync

install-frontend:
	cd frontend && uv sync

run: install
	@echo "Starting backend on http://localhost:3000 and frontend on http://localhost:8501"
	@cd backend && uv run uvicorn app:app --host 0.0.0.0 --port 3000 & \
	cd frontend && uv run streamlit run main.py --server.port 8501 --server.headless true; \
	wait

run-backend: install-backend
	cd backend && uv run uvicorn app:app --host 0.0.0.0 --port 3000

run-frontend: install-frontend
	cd frontend && uv run streamlit run main.py --server.port 8501 --server.headless true

test: test-backend test-frontend

test-backend: install-backend
	cd backend && uv run pytest

test-frontend: install-frontend
	cd frontend && uv run pytest
