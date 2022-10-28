FactoryBot.define do |f|

  PLAIN_RSA_KEY = "-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCYYrlPEKhz5ZPhxKXLvOtQR4FQ1EzpI3Kkx5lgXDmn8pIXwlKy
3uoFNTR4ANc9r4sbl/O0QhKh2/fcMFrqwhHO/cnPvSxtlWupIbgvl/MRB/f1tKrp
exPLtTocEFbUwFZL9gFxb4bDn1DPjzehA3afHeBYOdzPQ2NT3ypNJnNu4QIDAQAB
AoGBAIdsZQbQ5QNqaUvguP8g+3aytUeiBF/EcuPhxnqOO2b3+cFHnrr7w7mxGNn0
1VQqp1N0bM4rUeeqVtHF32Z15eBRM1cR+2OA4Tg1bs91OmC0Btpq/zNPGzhQCeN7
NEXsnzJhP7MOg8RmXGL89vDMJfjGrg3bsBGQmTezJelAK7wJAkEAx3tzafAUlWGv
wW5a1U2eRBKGVXXUgdnvn3TLaLArhDzzLJ4+o/42p9kAo4crVWRve/IZPF+wydb1
LyCfs72qhwJBAMOPVUKecFj9sD3gVheMsYNPtxR6P1goHQkX6GGSLF1in5hweuoq
hOMj1OR9ZzSRi27g0enrpoCanl4L9h9FbVcCQGHPUCnTg+Qy/8ByYatQ4ZczFhb1
LXt15p5i4BG2v7+ZOwrXlJNIZHgsWLnV3xOBqYA2ltUZfk+ZTKMM9gFlsCUCQQCK
ga0gZvkpflxiJs6zFTnwx/ficAcHWDngY+d5m78CUUS6Agh8a6r8+TbishLzv5Xi
7SafqACgm2JJN+2VDmY3AkBefIidvB3re7rBkUa/7x0AzXE1KIqDTHsyA1+Zw/+5
DVyMxqPfW1XvQj5Vx2naUio7gy3zg5Y+v7+LbJY2g7Cc
-----END RSA PRIVATE KEY-----"
  
  ENCRYPTED_RSA_KEY = "-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: DES-EDE3-CBC,9963545876551D27

Kz+7ouSRiyQ+htpZusNpQbFdFgv5dZl9uzqa2QWfs9XX/jckLERUrSuDxWmXaEs+
pCFvedInvB+1sRrY5cwqgIijGq4mQpch+yAvZKxHub3YHZolNW31Qu/aPE5x5cPT
KNDmkP7qwVWIS3XdsQtzQkDDajj+Q/3p7w3HtlIjvKCBHhYtdNBVbFLdL2Scc9MG
kbotrGNNiqtRXVlXZeisK/YhD9BEpsvQOwN+RE/H1j0YSEsSh2nSZPW1aDAYV1T5
lyYA3V3wIaJUyjhkYNDbSe/BCgVbbytM2uNEa507ktZksdgD4g52gzsDtgM7Mjdn
bsB43RvqM3UA18SrxYPY7gdniCOV0AAeryERr3VRsfeb+HSQ6nZYed/6wCNH0rfp
EPgepGw53/OLnE77v09dQ92Jj2hmk4gWJHDp3KS0UDvaf0rBMc8MdymsdnBnxOxG
nvW8u7eYp+z6+opmfarseccCw7w7vCnC++WOu+BOUOn9Apd7Kxzv2VVie54lcN4i
ZXY72SMN1cvKjlD7RgigTj8KCfIAVHnc+7Sq24kfS5N5IW2bNf2T1XXXqEZ7fr2A
EIZ0rNmeAtGXVN2dtGntytIy97ToGjDkw2L2STswi57jiCBuc0lrhg6Mp2w1xkEw
Lne7a61QnVz0ZccboQiqmB2TUUFAjNdzy97RqvHaqTvpe3ycJe1jDNoQ+MmxDqwB
PDDpNGSHUwlp3EzA0pEswC23vCyXMm6tWVb5CDSpxDQ3cahEPd4hI2yg37AOyEQU
kSCRlv+2Wm9Csu0Yvw74/4DiaTTGy8d0mglVDs/rYB3QUy6aT/Ya1g==
-----END RSA PRIVATE KEY-----"
  
  INVALID_RSA_KEY = "-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCYYrlPEKhz5ZPhxKXLvOtQR4FQ1EzpI3Kkx5lgXDmn8pIXwlKy
3uoFNTR4ANc9r4sbl/O0QhKh2/fcMFrqwhHO/cnPvSxtlWupIbgvl/MRB/f1tKrp
exPLtTocEFbUwFZL9gFxb4bDn1DPjzehA3afHeBYOdzPQ2NT3ypNJnNu4QIDAQAB
NEXsnzJhP7MOg8RmXGL89vDMJfjGrg3bsBGQmTezJelAK7wJAkEAx3tzafAUlWGv
wW5a1U2eRBKGVXXUgdnvn3TLaLArhDzzLJ4+o/42p9kAo4crVWRve/IZPF+wydb1
hOMj1OR9ZzSRi27g0enrpoCanl4L9h9FbVcCQGHPUCnTg+Qy/8ByYatQ4ZczFhb1
LXt15p5i4BG2v7+ZOwrXlJNIZHgsWLnV3xOBqYA2ltUZfk+ZTKMM9gFlsCUCQQCK
ga0gZvkpflxiJs6zFTnwx/ficAcHWDngY+d5m78CUUS6Agh8a6r8+TbishLzv5Xi
7SafqACgm2JJN+2VDmY3AkBefIidvB3re7rBkUa/7x0AzXE1KIqDTHsyA1+Zw/+5
DVyMxqPfW1XvQj5Vx2naUio7gy3zg5Y+v7+LbJY2g7Cc
-----END RSA PRIVATE KEY-----"
  
  VALID_SSL_CERTIFICATE = "-----BEGIN CERTIFICATE-----
MIID1DCCAbwCAQEwDQYJKoZIhvcNAQEFBQAwgYgxCzAJBgNVBAYTAkRFMREwDwYD
VQQIEwhTYWFybGFuZDEVMBMGA1UEBxMMU2FhcmJydWVja2VuMQ0wCwYDVQQKEwRh
dnRxMRAwDgYDVQQLEwdob3N0aW5nMQ0wCwYDVQQDEwRvbGxpMR8wHQYJKoZIhvcN
AQkBFhBvd29sZkBhdmFydGVxLmRlMB4XDTEzMDYyNTA3NDg1MloXDTE0MDYyNTA3
NDg1MlowWzELMAkGA1UEBhMCREUxEzARBgNVBAgTClNvbWUtU3RhdGUxCzAJBgNV
BAcTAnNiMQwwCgYDVQQKEwNvcmcxDTALBgNVBAsTBHVuaXQxDTALBgNVBAMTBG5h
bWUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAJhiuU8QqHPlk+HEpcu861BH
gVDUTOkjcqTHmWBcOafykhfCUrLe6gU1NHgA1z2vixuX87RCEqHb99wwWurCEc79
yc+9LG2Va6khuC+X8xEH9/W0qul7E8u1OhwQVtTAVkv2AXFvhsOfUM+PN6EDdp8d
4Fg53M9DY1PfKk0mc27hAgMBAAEwDQYJKoZIhvcNAQEFBQADggIBABbt7WxEu6A+
+Jszqm3j7UOT0JRcCb8QVjNQlejtpjpntQrRLUWl4YbCAtGTSLAIJ8x3zB8aOEQx
sZQ7BcVQipNgr3P3wSzCdFPGaqe5IuXq0UypmHjr854G+Dt997CIuvH1g9Qylnck
pClpswMhltvnkcjPGEGiBtH5dXyVrRklXzSDHmX4vg5dv1GVLpEnq5XrvKypN/Hq
zuWvyd6FUuXZ6BMlrfUoa4mZTxY3FGpcoqJugKAX5GOiNLz9sNpG4X9X37QnVPKE
0BHdkJoyTuAgaEH+/3bYNrx+VvU1mvY+M6QPr2joLLDtTro1M1+oOMyXwK99e2lS
3K0l6S546A2Po4Kw5txMz9ETId5N3cHo1hwwirGItLSFblNWitsLG56eW+sE+NoV
qh4F1fYl6XPcRlqel5H29a8uQWN3jWsDDnsih5PCvEEPMAJ+E+vDTNBo4bGeKHw5
mcnrksdX9+yqwtT5uev/7PXM6IdMTB+VxW6n0fiNa/nhMApDmHvVrxSSaht7QxiY
9T/X2Hd8SgTZAjeTbgTqxvhyAh1Y24ti6yIvUj35oZUlg5teO6W9LQOSklHgy7MH
nenMSGo4crCtBmTLWtqxhuizKD7OEEenXOUeGCDeDDGZOOgCcw9oVk5ZErhndTqR
7BeVZ1Q+foNw3Yl5o46J5K5AvIulzMCP
-----END CERTIFICATE-----"

  SSL_CERTIFICATE_WITH_USELESS_APPENDING = "-----BEGIN CERTIFICATE-----
MIID1DCCAbwCAQEwDQYJKoZIhvcNAQEFBQAwgYgxCzAJBgNVBAYTAkRFMREwDwYD
VQQIEwhTYWFybGFuZDEVMBMGA1UEBxMMU2FhcmJydWVja2VuMQ0wCwYDVQQKEwRh
dnRxMRAwDgYDVQQLEwdob3N0aW5nMQ0wCwYDVQQDEwRvbGxpMR8wHQYJKoZIhvcN
AQkBFhBvd29sZkBhdmFydGVxLmRlMB4XDTEzMDYyNTA3NDg1MloXDTE0MDYyNTA3
NDg1MlowWzELMAkGA1UEBhMCREUxEzARBgNVBAgTClNvbWUtU3RhdGUxCzAJBgNV
BAcTAnNiMQwwCgYDVQQKEwNvcmcxDTALBgNVBAsTBHVuaXQxDTALBgNVBAMTBG5h
bWUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAJhiuU8QqHPlk+HEpcu861BH
gVDUTOkjcqTHmWBcOafykhfCUrLe6gU1NHgA1z2vixuX87RCEqHb99wwWurCEc79
yc+9LG2Va6khuC+X8xEH9/W0qul7E8u1OhwQVtTAVkv2AXFvhsOfUM+PN6EDdp8d
4Fg53M9DY1PfKk0mc27hAgMBAAEwDQYJKoZIhvcNAQEFBQADggIBABbt7WxEu6A+
+Jszqm3j7UOT0JRcCb8QVjNQlejtpjpntQrRLUWl4YbCAtGTSLAIJ8x3zB8aOEQx
sZQ7BcVQipNgr3P3wSzCdFPGaqe5IuXq0UypmHjr854G+Dt997CIuvH1g9Qylnck
pClpswMhltvnkcjPGEGiBtH5dXyVrRklXzSDHmX4vg5dv1GVLpEnq5XrvKypN/Hq
zuWvyd6FUuXZ6BMlrfUoa4mZTxY3FGpcoqJugKAX5GOiNLz9sNpG4X9X37QnVPKE
0BHdkJoyTuAgaEH+/3bYNrx+VvU1mvY+M6QPr2joLLDtTro1M1+oOMyXwK99e2lS
3K0l6S546A2Po4Kw5txMz9ETId5N3cHo1hwwirGItLSFblNWitsLG56eW+sE+NoV
qh4F1fYl6XPcRlqel5H29a8uQWN3jWsDDnsih5PCvEEPMAJ+E+vDTNBo4bGeKHw5
mcnrksdX9+yqwtT5uev/7PXM6IdMTB+VxW6n0fiNa/nhMApDmHvVrxSSaht7QxiY
9T/X2Hd8SgTZAjeTbgTqxvhyAh1Y24ti6yIvUj35oZUlg5teO6W9LQOSklHgy7MH
nenMSGo4crCtBmTLWtqxhuizKD7OEEenXOUeGCDeDDGZOOgCcw9oVk5ZErhndTqR
7BeVZ1Q+foNw3Yl5o46J5K5AvIulzMCP
-----END CERTIFICATE-----
adsf
adf
ad
adsf"
  
  CORRUPT_SSL_CERTIFICATE = "-----BEGIN CERTIFICATE-----
MIID1DCCAbwCAQEwDQYJKoZIhacNAQEFBQAwgYgxCzAJBgNVBAYTAkRFMREwDwYD
VQQIEwhTYWFybGFuZDEVMBMGA1UEBxMMU2FhcmJydWVja2VuMQ0wCwYDVQQKEwRh
dnRxMRAwDgYDVQQLEwdob3N0aW5nMQ0wCwYDVQQDEwRvbGxpMR8wHQYJKoZIhvcN
AQkBFhBvd29sZkBhdmFydGVxLaRlMB4XDTEzMDYyNTA3NDg1MloXDTE0MDYyNTA3
NDg1MlowWzELMAkGA1UEBhMCREUxEzARBgNVBAgTClNvbWUtU3RhdGUxCzAJBgNV
BAcTAnNiMQwwCgYDVQQKEwNvcmcxDTALBgNVBAsTBHVuaXQxDTALBgNVBAMTBG5h
bWUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAJhiuU8QqHPlk+HEpcu861BH
gVDUTOajcqTHmWBcOafykhfCUrLe6gU1NHgA1z2vixuX87RCEqHb99wwWurCEc79
yc+9LG2Va6khuC+X8xEH9/W0qul7E8u1OhwQVtTAVkv2AXFvhsOfUM+PN6EDdp8d
4Fg53M9DY1PfKk0mc27hAgMBAaEwDQYJKoZIhvcNAQEFBQADggIBABbt7WxEu6A+
+Jszqm3j7UOT0JRcCb8QVjNQlejtpjpntQrRLUWl4YbCAtGTSLAIJ8x3zB8aOEQx
sZQ7BcVQipNgr3P3wSzCdFPGaqe5IuXq0UypmHjr854G+Dt997CIuvH1g9Qylnck
pClpswMhltvnkcjPGEGiBtH5dXyVrRklXzSDHmX4vg5dv1GVLpEnq5XrvKypN/Hq
zuWvyd6FUuXZ6BMlrfUoa4mZTeY3FGpcoqJugKAX5GOiNLz9sNpG4X9X37QnVPKE
0BHdkJoyTuAgaEH+/3bYNrx+VvU1mvY+M6QPr2joLLDtTro1M1+oOMyXwK99e2lS
3K0l6S546A2Po4Kw5txMz9ETId5N3cHo1hwwirGItLSFblNWitsLG56eW+sE+NoV
qh4F1fYl6XPcRlqel5H29a8uQWN3jWsDDnsih5PCvEEPMAJ+E+vDTNBo4bGeKHw5
mcnrksdX9+yqwtT5uev/7PXM6adMTB+VxW6n0fiNa/nhMApDmHvVrxSSaht7QxiY
9T/X2Hd8SgTZAjeTbgTqxvhyAh1Y24ti6yIvUj35oZUlg5teO6W9LQOSklHgy7MH
nenMSGo4crCtBmTLWtqxhuizKD7OEEenXOUeGCDeDDGZOOgCcw9oVk5ZErhndTqR
7BeVZ1Q+foNw3Yl5o46J5K5AvIulzMCP
-----END CERTIFICATE-----"
  
  INVALID_SSL_CERTIFICATE = "-----BEGIN CERTIFICATE-----
MIID1DCCAbwCAQEwDQYJKoZIhvcNAQEFBQAwgYgxCzAJBgNVBAYTAkRFMREwDwYD
VQQIEwhTYWFybGFuZDEVMBMGA1UEBxMMU2FhcmJydWVja2VuMQ0wCwYDVQQKEwRh
dnRxMRAwDgYDVQQLEwdob3N0aW5nMQ0wCwYDVQQDEwRvbGxpMR8wHQYJKoZIhvcN
AQkBFhBvd29sZkBhdmFydGVxLmRlMB4XDTEzMDYyNTA3NDg1MloXDTE0MDYyNTA3
NDg1MlowWzELMAkGA1UEBhMCREUxEzARBgNVBAgTClNvbWUtU3RhdGUxCzAJBgNV
BAcTAnNiMQwwCgYDVQQKEwNvcmcxDTALBgNVBAsTBHVuaXQxDTALBgNVBAMTBG5h
bWUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAJhiuU8QqHPlk+HEpcu861BH
gVDUTOkjcqTHmWBcOafykhfCUrLe6gU1NHgA1z2vixuX87RCEqHb99wwWurCEc79
yc+9LG2Va6khuC+X8xEH9/W0qul7E8u1OhwQVtTAVkv2AXFvhsOfUM+PN6EDdp8d
4Fg53M9DY1PfKk0mc27hAgMBAAEwDQYJKoZIhvcNAQEFBQADggIBABbt7WxEu6A+
3K0l6S546A2Po4Kw5txMz9ETId5N3cHo1hwwirGItLSFblNWitsLG56eW+sE+NoV
qh4F1fYl6XPcRlqel5H29a8uQWN3jWsDDnsih5PCvEEPMAJ+E+vDTNBo4bGeKHw5
mcnrksdX9+yqwtT5uev/7PXM6IdMTB+VxW6n0fiNa/nhMApDmHvVrxSSaht7QxiY
9T/X2Hd8SgTZAjeTbgTqxvhyAh1Y24ti6yIvUj35oZUlg5teO6W9LQOSklHgy7MH
nenMSGo4crCtBmTLWtqxhuizKD7OEEenXOUeGCDeDDGZOOgCcw9oVk5ZErhndTqR
7BeVZ1Q+foNw3Yl5o46J5K5AvIulzMCP
-----END CERTIFICATE-----"
  
  VALID_CA_CERTIFICATE = "-----BEGIN CERTIFICATE-----
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
-----END CERTIFICATE-----"
  
  INVALID_CA_CERTIFICATE = "----RTIFICATE-----
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
-----END CERTIFICATE-----"

  VALID_CERTIFICATE_WITH_ONE_SUBJECT_ALT_NAME = "-----BEGIN CERTIFICATE-----
MIIFRjCCBC6gAwIBAgIDCKGFMA0GCSqGSIb3DQEBBQUAMDwxCzAJBgNVBAYTAlVT
MRcwFQYDVQQKEw5HZW9UcnVzdCwgSW5jLjEUMBIGA1UEAxMLUmFwaWRTU0wgQ0Ew
HhcNMTIxMDA5MDg1NzAxWhcNMTMxMDExMTIyODA4WjCBzzEpMCcGA1UEBRMgTEx6
ZWJOMzFoclpDRnJ1WWovMWZzV3p2NThtN2VabmcxEzARBgNVBAsTCkdUNDQ5NTUz
NjkxMTAvBgNVBAsTKFNlZSB3d3cucmFwaWRzc2wuY29tL3Jlc291cmNlcy9jcHMg
KGMpMTIxLzAtBgNVBAsTJkRvbWFpbiBDb250cm9sIFZhbGlkYXRlZCAtIFJhcGlk
U1NMKFIpMSkwJwYDVQQDEyBtYWlsLmt1bmRlbnBvcnRhbC5yYWlsc2hvc3Rlci5k
ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAORxHMiSy0dScuAC68xe
xf0Zo6XwqjIpYifPF3v60gLAm0h23GsaJDH9vLtFGB63Sk1sl4cG9t8B5JjiWkNA
mH7+E0+CPa3qdYX87wZO/aXb2YiI71+rfemxtgrF1uGaC8cW/4z1f/YC4SiDm6N1
VE+iNTHRmov4ReP8TSPB2OcZYdaEPj9HX5dtU+qmXdSOOH5YS5fd5ns/e4MWPFe1
doQPAV7WeRenXG8pLcXLgi3wEyRrxtGx5h+965oznz36YPM3yKO5MU9NVUFRBbHE
TPm+/knEUTOTN11gTY8DtSfeQeLXmAFUCoGxsQI39DG7hqRjDs0Zc6LtxHma3P//
iUsCAwEAAaOCAbswggG3MB8GA1UdIwQYMBaAFGtpPWoYQkrdjwJlOf01JIZ4kRYw
MA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIw
KwYDVR0RBCQwIoIgbWFpbC5rdW5kZW5wb3J0YWwucmFpbHNob3N0ZXIuZGUwQwYD
VR0fBDwwOjA4oDagNIYyaHR0cDovL3JhcGlkc3NsLWNybC5nZW90cnVzdC5jb20v
Y3Jscy9yYXBpZHNzbC5jcmwwHQYDVR0OBBYEFH/TF2nNy+yz/MMsvEdiV4oAwKBz
MAwGA1UdEwEB/wQCMAAweAYIKwYBBQUHAQEEbDBqMC0GCCsGAQUFBzABhiFodHRw
Oi8vcmFwaWRzc2wtb2NzcC5nZW90cnVzdC5jb20wOQYIKwYBBQUHMAKGLWh0dHA6
Ly9yYXBpZHNzbC1haWEuZ2VvdHJ1c3QuY29tL3JhcGlkc3NsLmNydDBMBgNVHSAE
RTBDMEEGCmCGSAGG+EUBBzYwMzAxBggrBgEFBQcCARYlaHR0cDovL3d3dy5nZW90
cnVzdC5jb20vcmVzb3VyY2VzL2NwczANBgkqhkiG9w0BAQUFAAOCAQEAmMmICBGP
DUVgyi01B6mRKv2kmS3UsW29903i75O/rD5ZHlrNd9Svbay4TjvrmtvexI9qRXOa
kdLCZiihtt+5GK1qkvR5dRLbaKC0SGu7yjjJlPJ7iWHuaBHjQAEx9y7oijXL/vQL
N7I724yyUr6UEOOGhZOAKdPkIQKUhTqW7EeoZgkWKeCob+muNV0rzpGHhKmnqd95
Hqdbn3Q7XULYjgmVt/HYIe2b46t0vkIFA9EHw9BDbMH2NGgj/RUNuMZIx/zZ+R9U
sVTN7Uj/shtbc5Lr+bAQKv4gPC5jHHiihEITQhkvUHzSrEs4PfmiM0+lrG2kMjNm
MskUuvT+DPACaA==
-----END CERTIFICATE-----"

  VALID_CERTIFICATE_WITH_WWW_ALT_NAME = "-----BEGIN CERTIFICATE-----
MIIE3zCCA8egAwIBAgIDBcaZMA0GCSqGSIb3DQEBBQUAMDwxCzAJBgNVBAYTAlVT
MRcwFQYDVQQKEw5HZW9UcnVzdCwgSW5jLjEUMBIGA1UEAxMLUmFwaWRTU0wgQ0Ew
HhcNMTIwMzI0MjIwNjUyWhcNMTMwMzI3MDg1NTM3WjCB5zEpMCcGA1UEBRMgWkZp
UVJQVDA3c2VXcjdGdXhvQzI4QTRxWkhTNmF1d2MxCzAJBgNVBAYTAkRFMRkwFwYD
VQQKExB3d3cuZmFuY3llcnAuY29tMRMwEQYDVQQLEwpHVDEzMzY5MTExMTEwLwYD
VQQLEyhTZWUgd3d3LnJhcGlkc3NsLmNvbS9yZXNvdXJjZXMvY3BzIChjKTEyMS8w
LQYDVQQLEyZEb21haW4gQ29udHJvbCBWYWxpZGF0ZWQgLSBSYXBpZFNTTChSKTEZ
MBcGA1UEAxMQd3d3LmZhbmN5ZXJwLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALLjLXFY4YfQiiFmarJxschzcibZxVjPfE9MktipDkBx7rhaA13R
oGWZh02Sko+evMUcCNgmIMdxnvWLTYo7CW4Ozt9/k/23Vze9K/FsBT/LtzP3Xo2F
eNxz9Pw0nxKcJjBsNyOXUlEuN7z3baLNU4jzjRbcDlwc07CWVMo1KZyAyTGqDEo2
HspJHN6remCZ29lgw8zidrRp4bkKExD7rZcLPrkVrD6hMa1s2JPxj2Ctv43+BD7O
dsfJJffzF+QJhEyq3c4k3sr8omVsWnusfBxtJmkaw3klWXQWLydDdlcinf7PQWmy
r5COHNBZYGF4xS0VIiN+ho0Sku1OjnhHQFcCAwEAAaOCATwwggE4MB8GA1UdIwQY
MBaAFGtpPWoYQkrdjwJlOf01JIZ4kRYwMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUE
FjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwKQYDVR0RBCIwIIIQd3d3LmZhbmN5ZXJw
LmNvbYIMZmFuY3llcnAuY29tMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9yYXBp
ZHNzbC1jcmwuZ2VvdHJ1c3QuY29tL2NybHMvcmFwaWRzc2wuY3JsMB0GA1UdDgQW
BBT5NXLLas0ZZTqp64H/qpYVOzYiADAMBgNVHRMBAf8EAjAAMEkGCCsGAQUFBwEB
BD0wOzA5BggrBgEFBQcwAoYtaHR0cDovL3JhcGlkc3NsLWFpYS5nZW90cnVzdC5j
b20vcmFwaWRzc2wuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQB4ViUS3c0bAN0hVzjs
MyAvDaoCv9n+Mgtn6qKcYzULRON+Azp/u6iQmC4xWPUWmJvw8DC/OB4B3rU4+oWe
HtkK1VfEn25vIKWKogoDQ1uS4JxuUmS5b0mgd3PEi1oQjLKKnanvSgYfn9S0qZcr
bOxaR1EU0H59wfs/xPiUOzl4MQxVlciacZhGlQWtBhDYfp2kvtbdvHDFGtvwWUCB
tMTuqpdlRJXrxeAUgcgXWsEWE84AJYCMvJf3sgIRHABv5TWsoCXPQAtd8bdvZ4pD
u8D2iTjzzIkrRR8Y7s29Pa3xfnBjUsXPli4jHscxOkpGhWY/3DJf4Ti5ABzIs35k
eB2Z
-----END CERTIFICATE-----"

  VALID_WILDCARD_CERTIFICATE = "-----BEGIN CERTIFICATE-----
MIIEuTCCA6GgAwIBAgIDBw73MA0GCSqGSIb3DQEBBQUAMDwxCzAJBgNVBAYTAlVT
MRcwFQYDVQQKEw5HZW9UcnVzdCwgSW5jLjEUMBIGA1UEAxMLUmFwaWRTU0wgQ0Ew
HhcNMTIwNjIxMTIxNjI0WhcNMTMwNjIzMjI1OTM0WjCBvzEpMCcGA1UEBRMgdktC
eFY4N1JVN2dzaVVvbk5VUnN2VXdlcUJSOWNReVUxEzARBgNVBAsTCkdUMjM4ODYy
MTExMTAvBgNVBAsTKFNlZSB3d3cucmFwaWRzc2wuY29tL3Jlc291cmNlcy9jcHMg
KGMpMTIxLzAtBgNVBAsTJkRvbWFpbiBDb250cm9sIFZhbGlkYXRlZCAtIFJhcGlk
U1NMKFIpMRkwFwYDVQQDDBAqLnJhaWxzaG9zdGVyLmRlMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAyJTSnPae5a06xFhY7yPXsogwiGm4CU+fmzBG+Lme
BZELUHW2PK11Jg+tgDkdmrUMadgs5HyqCxSEEDQPRS8ohOTBdhlaoAEbXDoqu7zJ
plGzI6da2ZReZPmvke+El8rQ6IT2XtG1iXhhCn4usq2znKyMPZMpeq786Rg1Zik4
KpoQFhMm+KsNk8G+JjuS0UTZk+wutStCCrvDr3Dm22MGqetaOIWatN7+Grtu3SbL
2ehy8IWdQYrH2CPzZaNiV8HXXiEaWDr7XoaAMiiez8x+k4gGijk22/Q8qNEHyINb
6ifbUnIJJTavKpSyutcf8XMq6NwfdqzNtg37wTbyIQgNJwIDAQABo4IBPjCCATow
HwYDVR0jBBgwFoAUa2k9ahhCSt2PAmU5/TUkhniRFjAwDgYDVR0PAQH/BAQDAgWg
MB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjArBgNVHREEJDAighAqLnJh
aWxzaG9zdGVyLmRlgg5yYWlsc2hvc3Rlci5kZTBDBgNVHR8EPDA6MDigNqA0hjJo
dHRwOi8vcmFwaWRzc2wtY3JsLmdlb3RydXN0LmNvbS9jcmxzL3JhcGlkc3NsLmNy
bDAdBgNVHQ4EFgQUxlhWUE7jpucQNwhQR4061lEre5swDAYDVR0TAQH/BAIwADBJ
BggrBgEFBQcBAQQ9MDswOQYIKwYBBQUHMAKGLWh0dHA6Ly9yYXBpZHNzbC1haWEu
Z2VvdHJ1c3QuY29tL3JhcGlkc3NsLmNydDANBgkqhkiG9w0BAQUFAAOCAQEAmCZ/
6o8k43rH22dofoL7KceRUxP4/L8fc4ft7ny0s+Txju+C6dC8Qnl8Aqc1GxU6kdBg
kLXE77g0zjZvjItOYXGq7MVLQuYpAu3W9fAa81gv4er4VEBTcNjbAR3pf83vYUBL
RVhmwjn6g9iDCqT3yzHsUpDGheYWuG4+2LrQAQPx6kk/pqrNz52RFrHJhZZjDl5c
UwraT6YXu1OR8fYbrT83I35c/iZ5ahnCFld1kCsP5gqZMgAgeu1af6YVxIF2YJL9
JralMRfUuJ6/FGfjimDifIST+0pmvD7bnlgCnMkKoZwq66+sYoWhXwI0O3PQFuDS
YGixHCwXW0s/3aHDWA==
-----END CERTIFICATE-----"
  
  factory :valid_v_host, :class => VHost do
    server_name { "example.de" }
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { VALID_SSL_CERTIFICATE }
    ssl_ca_certificate { VALID_CA_CERTIFICATE }
    ssl_key { PLAIN_RSA_KEY }
  end

  factory :valid_v_host_without_ca_cert, :class => VHost do
    server_name { "example.de" }
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { VALID_SSL_CERTIFICATE }
    ssl_ca_certificate {""}
    ssl_key { PLAIN_RSA_KEY }
  end
  
  factory :v_host_with_encrypted_ssl_key, :class => VHost do
    server_name { "example.de" }
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { VALID_SSL_CERTIFICATE }
    ssl_ca_certificate { VALID_CA_CERTIFICATE }
    ssl_key { ENCRYPTED_RSA_KEY }
  end
  
  factory :v_host_with_invalid_ssl_key, :class => VHost do
    server_name { "example.de" }
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { VALID_SSL_CERTIFICATE }
    ssl_ca_certificate { VALID_CA_CERTIFICATE }
    ssl_key { INVALID_RSA_KEY }
  end
  
  factory :v_host_with_invalid_ssl_certificate, :class => VHost do
    server_name { "example.de" }
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { INVALID_SSL_CERTIFICATE }
    ssl_ca_certificate { VALID_CA_CERTIFICATE }
    ssl_key { PLAIN_RSA_KEY }
  end
  
  factory :v_host_with_invalid_ssl_ca_certificate, :class => VHost do
    server_name { "example.de" }
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { VALID_SSL_CERTIFICATE }
    ssl_ca_certificate { INVALID_CA_CERTIFICATE }
    ssl_key { PLAIN_RSA_KEY }
  end
  
  factory :v_host_with_corrupt_ssl_certificate, :class => VHost do
    server_name { "example.de" }
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { CORRUPT_SSL_CERTIFICATE }
    ssl_ca_certificate { VALID_CA_CERTIFICATE }
    ssl_key { PLAIN_RSA_KEY }
  end

  factory :v_host_with_ssl_certificate_containing_usless_appending, :class => VHost do
    server_name { "example.de" }
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { SSL_CERTIFICATE_WITH_USELESS_APPENDING }
    ssl_ca_certificate { VALID_CA_CERTIFICATE }
    ssl_key { PLAIN_RSA_KEY }
  end

  factory :v_host_with_one_subject_alt_name, :class => VHost do
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { VALID_CERTIFICATE_WITH_ONE_SUBJECT_ALT_NAME }
  end

  factory :v_host_with_www_alt_name, :class => VHost do
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { VALID_CERTIFICATE_WITH_WWW_ALT_NAME }
  end

  factory :v_host_with_wildcard_certificate, :class => VHost do
    organization_guid { "a-valid-org-guid" }
    ssl_certificate { VALID_WILDCARD_CERTIFICATE }
  end

end