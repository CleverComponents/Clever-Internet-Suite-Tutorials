unit clOpenSsl;

interface

type
  POPENSSL_INIT_SETTINGS = Pointer; //ossl_init_settings_st
  PSSL_CTX = Pointer; //ssl_ctx_st
  PSSL_METHOD = Pointer; //ssl_method_st
  PX509_STORE_CTX = Pointer; //x509_store_ctx_st
  PSSL = Pointer; //ssl_st

  PBIO = Pointer; //bio_st
  PBIO_METHOD = Pointer; //bio_method_st

  PX509 = Pointer; //x509_st
  PPX509 = ^PX509;
  PX509_NAME = Pointer; //X509_name_st

  PEVP_PKEY = Pointer;//evp_pkey_st
  PPEVP_PKEY = ^PEVP_PKEY;

const
  LIBSSL_NAME = 'libssl-3.dll';
  LIBCRYPTO_NAME = 'libcrypto-3.dll';

//int OPENSSL_init_ssl(uint64_t opts, const OPENSSL_INIT_SETTINGS *settings);
function OPENSSL_init_ssl(opts: UInt64; settings: POPENSSL_INIT_SETTINGS): Integer; cdecl;
external LIBSSL_NAME name 'OPENSSL_init_ssl';

//int OPENSSL_init_crypto(uint64_t opts, const OPENSSL_INIT_SETTINGS *settings);
function OPENSSL_init_crypto(opts: UInt64; settings: POPENSSL_INIT_SETTINGS): Integer; cdecl;
external LIBCRYPTO_NAME name 'OPENSSL_init_crypto';

//void OPENSSL_cleanup(void);
procedure OPENSSL_cleanup; cdecl;
external LIBCRYPTO_NAME name 'OPENSSL_cleanup';

//SSL_CTX *SSL_CTX_new(const SSL_METHOD *meth);
function SSL_CTX_new(meth: PSSL_METHOD): PSSL_CTX; cdecl;
external LIBSSL_NAME name 'SSL_CTX_new';

//const SSL_METHOD *TLS_method(void);
function TLS_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLS_method';

//const SSL_METHOD *TLS_server_method(void);
function TLS_server_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLS_server_method';

//const SSL_METHOD *TLS_client_method(void);
function TLS_client_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLS_client_method';

//const SSL_METHOD *TLSv1_method(void);
function TLSv1_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLSv1_method';

//const SSL_METHOD *TLSv1_server_method(void);
function TLSv1_server_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLSv1_server_method';

//const SSL_METHOD *TLSv1_client_method(void);
function TLSv1_client_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLSv1_client_method';

//const SSL_METHOD *TLSv1_1_method(void);
function TLSv1_1_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLSv1_1_method';

//const SSL_METHOD *TLSv1_1_server_method(void);
function TLSv1_1_server_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLSv1_1_server_method';

//const SSL_METHOD *TLSv1_1_client_method(void);
function TLSv1_1_client_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLSv1_1_client_method';

//const SSL_METHOD *TLSv1_2_method(void);
function TLSv1_2_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLSv1_2_method';

//const SSL_METHOD *TLSv1_2_server_method(void);
function TLSv1_2_server_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLSv1_2_server_method';

//const SSL_METHOD *TLSv1_2_client_method(void);
function TLSv1_2_client_method: PSSL_METHOD; cdecl;
external LIBSSL_NAME name 'TLSv1_2_client_method';

//void SSL_CTX_free(SSL_CTX *ctx);
procedure SSL_CTX_free(ctx: PSSL_CTX); cdecl;
external LIBSSL_NAME name 'SSL_CTX_free';

//unsigned long ERR_get_error(void);
function ERR_get_error: Cardinal; cdecl;
external LIBCRYPTO_NAME name 'ERR_get_error';

//void ERR_error_string_n(unsigned long e, char *buf, size_t len);
procedure ERR_error_string_n(e: Cardinal; buf: PAnsiChar; len: NativeUInt); cdecl;
external LIBCRYPTO_NAME name 'ERR_error_string_n';

type
//typedef int (*SSL_verify_cb)(int preverify_ok, X509_STORE_CTX *x509_ctx);
  TSSL_verify_cb = function(preverify_ok: Integer; x509_ctx: PX509_STORE_CTX): Integer; cdecl;

const
  SSL_VERIFY_NONE = $0;
  SSL_VERIFY_PEER = $01;
  SSL_VERIFY_FAIL_IF_NO_PEER_CERT = $02;
  SSL_VERIFY_CLIENT_ONCE = $04;
  SSL_VERIFY_POST_HANDSHAKE = $08;

//void SSL_CTX_set_verify(SSL_CTX *ctx, int mode, SSL_verify_cb callback);
procedure SSL_CTX_set_verify(ctx: PSSL_CTX; mode: Integer; callback: TSSL_verify_cb); cdecl;
external LIBSSL_NAME name 'SSL_CTX_set_verify';

//int SSL_get_ex_data_X509_STORE_CTX_idx(void);
function SSL_get_ex_data_X509_STORE_CTX_idx: Integer; cdecl;
external LIBSSL_NAME name 'SSL_get_ex_data_X509_STORE_CTX_idx';

//int SSL_CTX_use_certificate(SSL_CTX *ctx, X509 *x);
function SSL_CTX_use_certificate(ctx: PSSL_CTX; cert: PX509): Integer; cdecl;
external LIBSSL_NAME name 'SSL_CTX_use_certificate';

//int SSL_CTX_use_PrivateKey(SSL_CTX *ctx, EVP_PKEY *pkey);
function SSL_CTX_use_PrivateKey(ctx: PSSL_CTX; pkey: PEVP_PKEY): Integer; cdecl;
external LIBSSL_NAME name 'SSL_CTX_use_PrivateKey';

//int SSL_CTX_check_private_key(const SSL_CTX *ctx);
function SSL_CTX_check_private_key(ctx: PSSL_CTX): Integer; cdecl;
external LIBSSL_NAME name 'SSL_CTX_check_private_key';

//SSL *SSL_new(SSL_CTX *ctx);
function SSL_new(ctx: PSSL_CTX): PSSL; cdecl;
external LIBSSL_NAME name 'SSL_new';

//void SSL_free(SSL *ssl);
procedure SSL_free(ssl: PSSL); cdecl;
external LIBSSL_NAME name 'SSL_free';

//void *SSL_get_ex_data(const SSL *ssl, int idx);
function SSL_get_ex_data(ssl: PSSL; idx: Integer): Pointer; cdecl;
external LIBSSL_NAME name 'SSL_get_ex_data';

//int SSL_set_ex_data(SSL *ssl, int idx, void *data);
function SSL_set_ex_data(ssl: PSSL; idx: Integer; data: Pointer): Integer; cdecl;
external LIBSSL_NAME name 'SSL_set_ex_data';

//void SSL_set_bio(SSL *s, BIO *rbio, BIO *wbio);
procedure SSL_set_bio(s: PSSL; rbio, wbio: PBIO); cdecl;
external LIBSSL_NAME name 'SSL_set_bio';

//void SSL_set0_rbio(SSL *s, BIO *rbio);
procedure SSL_set0_rbio(s: PSSL; rbio: PBIO); cdecl;
external LIBSSL_NAME name 'SSL_set0_rbio';

//void SSL_set0_wbio(SSL *s, BIO *wbio);
procedure SSL_set0_wbio(s: PSSL; wbio: PBIO); cdecl;
external LIBSSL_NAME name 'SSL_set0_wbio';

//BIO *SSL_get_rbio(const SSL *s);
function SSL_get_rbio(s: PSSL): PBIO; cdecl;
external LIBSSL_NAME name 'SSL_get_rbio';

//BIO *SSL_get_wbio(const SSL *s);
function SSL_get_wbio(s: PSSL): PBIO; cdecl;
external LIBSSL_NAME name 'SSL_get_wbio';

//void SSL_set_connect_state(SSL *s);
procedure SSL_set_connect_state(s: PSSL); cdecl;
external LIBSSL_NAME name 'SSL_set_connect_state';

//void SSL_set_accept_state(SSL *s);
procedure SSL_set_accept_state(s: PSSL); cdecl;
external LIBSSL_NAME name 'SSL_set_accept_state';

//int SSL_do_handshake(SSL *s);
function SSL_do_handshake(s: PSSL): Integer; cdecl;
external LIBSSL_NAME name 'SSL_do_handshake';

const
  SSL_ERROR_NONE = 0;
  SSL_ERROR_SSL = 1;
  SSL_ERROR_WANT_READ = 2;
  SSL_ERROR_WANT_WRITE = 3;
  SSL_ERROR_SYSCALL = 5;// look at error stack/return value/errno
  SSL_ERROR_ZERO_RETURN = 6;

//int SSL_get_error(const SSL *s, int ret_code);
function SSL_get_error(s: PSSL; ret_code: Integer): Integer; cdecl;
external LIBSSL_NAME name 'SSL_get_error';

//const char *SSL_get_cipher_list(const SSL *s, int n);
function SSL_get_cipher_list(s: PSSL; n: Integer): PAnsiChar; cdecl;
external LIBSSL_NAME name 'SSL_get_cipher_list';

//int SSL_is_init_finished(const SSL *s);
function SSL_is_init_finished(s: PSSL): Integer; cdecl;
external LIBSSL_NAME name 'SSL_is_init_finished';

//int SSL_read(SSL *ssl, void *buf, int num);
function SSL_read(ssl: PSSL; buf: Pointer; num: Integer): Integer; cdecl;
external LIBSSL_NAME name 'SSL_read';

//int SSL_write(SSL *ssl, const void *buf, int num);
function SSL_write(ssl: PSSL; buf: Pointer; num: Integer): Integer; cdecl;
external LIBSSL_NAME name 'SSL_write';

//int SSL_pending(const SSL *s);
function SSL_pending(s: PSSL): Integer; cdecl;
external LIBSSL_NAME name 'SSL_pending';

//int SSL_shutdown(SSL *s);
function SSL_shutdown(s: PSSL): Integer;  cdecl;
external LIBSSL_NAME name 'SSL_shutdown';

//BIO *BIO_new_mem_buf(const void *buf, int len);
function BIO_new_mem_buf(buf: Pointer; len: Integer): PBIO; cdecl;
external LIBCRYPTO_NAME name 'BIO_new_mem_buf';

//BIO *BIO_new(const BIO_METHOD *type);
function BIO_new(btype: PBIO_METHOD): PBIO; cdecl;
external LIBCRYPTO_NAME name 'BIO_new';

//BIO_METHOD *BIO_s_mem(void);
function BIO_s_mem: PBIO_METHOD; cdecl;
external LIBCRYPTO_NAME name 'BIO_s_mem';

//int BIO_free(BIO *a);
function BIO_free(b: PBIO): Integer; cdecl;
external LIBCRYPTO_NAME name 'BIO_free';

//int BIO_read(BIO *b, void *data, int dlen);
function BIO_read(b: PBIO; data: Pointer; dlen: Integer): Integer; cdecl;
external LIBCRYPTO_NAME name 'BIO_read';

//int BIO_write(BIO *b, const void *data, int dlen);
function BIO_write(b: PBIO; data: Pointer; dlen: Integer): Integer; cdecl;
external LIBCRYPTO_NAME name 'BIO_write';

const
  BIO_CTRL_SET = 4;// man - set the 'IO' type
  BIO_CTRL_GET = 5;// man - get the 'IO' type
  BIO_CTRL_PENDING = 10;// opt - is their more data buffered
  BIO_CTRL_WPENDING = 13;// opt - number of bytes still to write

//long BIO_ctrl(BIO *bp, int cmd, long larg, void *parg);
function BIO_ctrl(bp: PBIO; cmd: Integer; larg: Cardinal; parg: Pointer): Cardinal; cdecl;
external LIBCRYPTO_NAME name 'BIO_ctrl';

type
//typedef int pem_password_cb (char *buf, int size, int rwflag, void *userdata);
  Tpem_password_cb = function(buf: Pointer; size: Integer; rwflag: Integer; userdata: Pointer): Integer; cdecl;

//X509 *PEM_read_bio_X509_AUX(BIO *bp, X509 **x, pem_password_cb *cb, void *u);
function PEM_read_bio_X509_AUX(bp: PBIO; x: PPX509; cb: Tpem_password_cb; u: Pointer): PX509; cdecl;
external LIBCRYPTO_NAME name 'PEM_read_bio_X509_AUX';

//X509 *PEM_read_bio_X509(BIO *bp, X509 **x, pem_password_cb *cb, void *u);
function PEM_read_bio_X509(bp: PBIO; x: PPX509; cb: Tpem_password_cb; u: Pointer): PX509; cdecl;
external LIBCRYPTO_NAME name 'PEM_read_bio_X509';

//EVP_PKEY *PEM_read_bio_PrivateKey(BIO *bp, EVP_PKEY **x, pem_password_cb *cb, void *u);
function PEM_read_bio_PrivateKey(bp : PBIO; x: PPEVP_PKEY; cb: Tpem_password_cb; u: Pointer): PEVP_PKEY; cdecl;
external LIBCRYPTO_NAME name 'PEM_read_bio_PrivateKey';

//void X509_free(X509 *a);
procedure X509_free(a: PX509); cdecl;
external LIBCRYPTO_NAME name 'X509_free';

//void EVP_PKEY_free(EVP_PKEY *pkey);
procedure EVP_PKEY_free(pkey: PEVP_PKEY); cdecl;
external LIBCRYPTO_NAME name 'EVP_PKEY_free';

//void *X509_STORE_CTX_get_ex_data(const X509_STORE_CTX *ctx, int idx);
function X509_STORE_CTX_get_ex_data(ctx: PX509_STORE_CTX; idx: Integer): Pointer; cdecl;
external LIBCRYPTO_NAME name 'X509_STORE_CTX_get_ex_data';

//X509 *X509_STORE_CTX_get_current_cert(const X509_STORE_CTX *ctx);
function X509_STORE_CTX_get_current_cert(ctx: PX509_STORE_CTX): PX509; cdecl;
external LIBCRYPTO_NAME name 'X509_STORE_CTX_get_current_cert';

const
  X509_V_OK = 0;
  //TODO add X509_V_ERR_CERT_HAS_EXPIRED and others to ignore

//int X509_STORE_CTX_get_error(const X509_STORE_CTX *ctx);
function X509_STORE_CTX_get_error(ctx: PX509_STORE_CTX): Integer; cdecl;
external LIBCRYPTO_NAME name 'X509_STORE_CTX_get_error';

//int X509_STORE_CTX_get_error_depth(const X509_STORE_CTX *ctx);
function X509_STORE_CTX_get_error_depth(ctx: PX509_STORE_CTX): Integer; cdecl;
external LIBCRYPTO_NAME name 'X509_STORE_CTX_get_error_depth';

//const char *X509_verify_cert_error_string(long n);
function X509_verify_cert_error_string(n: Cardinal): PAnsiChar; cdecl;
external LIBCRYPTO_NAME name 'X509_verify_cert_error_string';

//X509_NAME *X509_get_subject_name(const X509 *a);
function X509_get_subject_name(a: PX509): PX509_NAME; cdecl;
external LIBCRYPTO_NAME name 'X509_get_subject_name';

//char *X509_NAME_oneline(const X509_NAME *a, char *buf, int size);
function X509_NAME_oneline(a: PX509_NAME; buf: PAnsiChar; size: Integer): PAnsiChar; cdecl;
external LIBCRYPTO_NAME name 'X509_NAME_oneline';

const
  XN_FLAG_COMPAT = 0;// Traditional; use old X509_NAME_print
  XN_FLAG_SEP_COMMA_PLUS = (1 shl 16);// RFC2253 ,+
  XN_FLAG_SEP_CPLUS_SPC = (2 shl 16);// ,+ spaced: more readable
  XN_FLAG_SEP_SPLUS_SPC = (3 shl 16);// ;+ spaced
  XN_FLAG_SEP_MULTILINE = (4 shl 16);// One line per field

  XN_FLAG_DN_REV = (1 shl 20);// Reverse DN order

  XN_FLAG_FN_SN = 0;// Object short name
  XN_FLAG_FN_LN = (1 shl 21);// Object long name
  XN_FLAG_FN_OID = (2 shl 21);// Always use OIDs
  XN_FLAG_FN_NONE = (3 shl 21);// No field names

  XN_FLAG_SPC_EQ = (1 shl 23);// Put spaces round '='

  ASN1_STRFLGS_UTF8_CONVERT = $10;

//int X509_NAME_print_ex(BIO *out, const X509_NAME *nm, int indent, unsigned long flags);
function X509_NAME_print_ex(out: PBIO; nm: PX509_NAME; indent: Integer; flags: Cardinal): Integer; cdecl;
external LIBCRYPTO_NAME name 'X509_NAME_print_ex';

implementation

end.
