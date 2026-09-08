import pytest
from main import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_endpoint(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b"Salom Sanjar" in response.data

def test_health_endpoint(client):
    response = client.get('/health')
    assert response.status_code == 200
    data = response.get_json()
    assert data["status"] == "healthy"
    assert data["service"] == "devops-practice-api"
    assert "uptime_seconds" in data

def test_info_endpoint(client):
    response = client.get('/info')
    assert response.status_code == 200
    data = response.get_json()
    assert data["version"] == "1.1.0"
    assert data["author"] == "Sanjar Oktamov"

def test_404_not_found(client):
    response = client.get('/nonexistent-endpoint')
    assert response.status_code == 404
