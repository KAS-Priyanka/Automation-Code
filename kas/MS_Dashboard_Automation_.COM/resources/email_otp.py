import imaplib
import email
import re
import time

def fetch_otp(username, password):
    # Connect to Gmail IMAP
    mail = imaplib.IMAP4_SSL("imap.gmail.com")
    mail.login(username, password)
    mail.select("inbox")

    time.sleep(8)  # wait for OTP mail

    # Get latest email
    _, data = mail.search(None, "ALL")
    mail_ids = data[0].split()
    latest = mail_ids[-1]

    _, msg_data = mail.fetch(latest, "(RFC822)")
    raw = msg_data[0][1]

    msg = email.message_from_bytes(raw)

    # Extract email body
    body = ""
    if msg.is_multipart():
        for part in msg.walk():
            if part.get_content_type() == "text/plain":
                body = part.get_payload(decode=True).decode()
                break
    else:
        body = msg.get_payload(decode=True).decode()

    # Extract 6-digit OTP
    otp = re.search(r"\d{6}", body).group()
    return otp