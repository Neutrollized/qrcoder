import os, secrets, tempfile
import urllib.request
import qrcode
import validators

from flask import Flask, render_template, request
from google.cloud import storage
from PIL import Image


app = Flask(__name__)


#---------------
# GCS setup
#---------------
gcs = storage.Client()
bucket = gcs.get_bucket(os.environ.get('QRCODER_GCS_BUCKET', 'qrcode-test'))


#---------------
# Helpers
#---------------
def fix_url(url):
  url = url.lower()
  if not url.startswith("https://"):
    return 'https://' + url
  else:
    return url

def generate_qrcode(url):
  qr = qrcode.QRCode(
      version=2,
      error_correction=qrcode.constants.ERROR_CORRECT_H,
      box_size=12,
      border=3,
  )
  qr.add_data(url)
  qr.make(fit=True)
  img = qr.make_image(fill_color="black", back_color="white")
  output_filename = 'qrcode_' + secrets.token_hex(4) + '.png'
  img.save(output_filename)
  
  blob = bucket.blob(output_filename)
  blob.upload_from_filename(output_filename)
  os.remove(output_filename)
  blob.make_public()

  return blob.public_url, output_filename


#---------------
# Routes
#---------------
@app.route('/')
def home():
  return render_template('index.html')

@app.route('/', methods=['POST'])
def index():
  text = request.form['text']

  # required because checkbox will not pass anything if it's not checked
  if request.form.get('skipurlvalidate') == 'checked':
    # checkbox is checked, skip URL validate
    # pass text as is
    public_url, filename = generate_qrcode(text)
    with tempfile.NamedTemporaryFile() as temp:
      localfile, header = urllib.request.urlretrieve(public_url)
      with Image.open(localfile) as im:
        return render_template('index.html', url=text, filename=filename)
  else:
    # fix URL and validate
    url = fix_url(text)
    if validators.url(url):
      public_url, filename = generate_qrcode(url)
      with tempfile.NamedTemporaryFile() as temp:
        localfile, header = urllib.request.urlretrieve(public_url)
        with Image.open(localfile) as im:
          return render_template('index.html', url=url, filename=filename)
    else:
      return render_template('index.html', url='INVALID URL')


#---------------
# Main
#---------------
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
