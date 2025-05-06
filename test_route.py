import requests

# Địa chỉ URL của ứng dụng Flask của bạn
base_url = "http://127.0.0.1:5000"

# Danh sách các route cần kiểm tra
routes = [
    '/students', 
    '/money', 
    '/timeslots', 
    '/classes', 
    '/grades', 
    '/schedules'
]

def test_get_route(route):
    try:
        url = f"{base_url}{route}"
        response = requests.get(url)
        print(f"GET {url} - Status Code: {response.status_code}")
        if response.status_code == 200:
            print(f"Response: {response.json()}")
        else:
            print(f"Error: {response.text}")
    except Exception as e:
        print(f"Failed to reach {route}: {e}")

def test_post_route(route, data):
    try:
        url = f"{base_url}{route}"
        response = requests.post(url, json=data)
        print(f"POST {url} - Status Code: {response.status_code}")
        if response.status_code == 201:
            print(f"Response: {response.json()}")
        else:
            print(f"Error: {response.text}")
    except Exception as e:
        print(f"Failed to reach {route}: {e}")

def main():
    # Kiểm tra các route GET
    for route in routes:
        test_get_route(route)
    
    # Kiểm tra route POST (ví dụ thêm học sinh mới)
    post_data = {
    "StudentName": "Thanh Mo",
    "Email": "mo@example.com",
    "Address": "123 Main St", 
    "BirthDate": "2000-01-01"
    }
    test_post_route('/students', post_data)

if __name__ == "__main__":
    main()
