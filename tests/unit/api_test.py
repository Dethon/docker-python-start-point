class TestApi:
    """Test class for the REST API"""

    def test_root_get(self, test_client_fixture):
        """Tests the basic greeting endpoint"""

        response = test_client_fixture.get("/")
        assert response.status_code == 200
        assert response.json() == {"greeting": "Hello world!"}
