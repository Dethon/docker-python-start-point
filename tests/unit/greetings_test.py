from syl.greetings import hello_world


class TestGreetings:
    """Test class for the greeting module"""

    def test_hello_world(self):
        """Tests that hello_world() returns the correct type of greeting"""

        assert hello_world() == "Hello world!"
