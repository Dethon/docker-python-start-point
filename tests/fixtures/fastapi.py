import pytest
from typing import Generator
from fastapi.testclient import TestClient
from syl.entrypoints import app


@pytest.fixture(scope="module")
def test_client_fixture() -> Generator[TestClient, None, None]:
    """This fixture generates a test client to be used when testing FASTAPI endpoints"""

    client = TestClient(app)
    yield client
