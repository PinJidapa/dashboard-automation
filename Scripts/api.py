import requests
from requests_toolbelt.multipart.encoder import MultipartEncoder


def upload_file(base_url, file_path, file_mime_type, headers=None):
    # Set a default Content-Type header
    default_headers = {'Content-Type': 'multipart/form-data'}

    # Combine the default headers with the incoming headers
    combined_headers = {**default_headers, **(headers or {})}  # Use an empty dictionary if headers is None
    encoder = MultipartEncoder(
        fields={
            'file': ('file', open(file_path, 'rb'), file_mime_type)
        }
    )
    # Add the Content-Type header with the boundary generated by the encoder
    combined_headers['Content-Type'] = encoder.content_type
    
    
    # Make the POST request with the MultipartEncoder and combined headers
    r = requests.post(base_url, data=encoder, headers=combined_headers)
    return r.json()

    
    
def upload_multiple_files(base_url,file_paths,headers):
    files = []
    for file_path in file_paths:
        files.append(('file', open(file_path, 'rb')))
    r = requests.post(base_url, files=files, headers=headers)
    return r.json() 