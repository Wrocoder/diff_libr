# small helper
import requests


def get_csv_from_url(url, file_name):
    try:
        req = requests.get(url)
        url_content = req.content
        csv_file = open(file_name, 'wb')
        csv_file.write(url_content)
        csv_file.close()
        print(f"File downloaded: {file_name}")

    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        return None