import unittest
from Data import Data

class DataTest(unittest.TestCase):

    def test_addTitle(self):
        data = Data("test/test-add-title.csv")

        data.addTitle()

        self.assertEqual("Mr", data.title(0))


if __name__ == '__main__':
    unittest.main()
