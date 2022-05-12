import pytest
from fastapi.testclient import TestClient

from main import app


@pytest.fixture(scope="module")
def test_client_fixture():
    """This fixture generates a test client to be used when testing FASTAPI endpoints"""

    client = TestClient(app)
    yield client
