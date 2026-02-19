"""Production settings overrides for Misago."""

import os

from django.core.exceptions import ImproperlyConfigured

from .settings import *  # noqa: F401,F403


DEBUG = False

SECRET_KEY = os.environ.get("DJANGO_SECRET_KEY")
if not SECRET_KEY:
    raise ImproperlyConfigured("DJANGO_SECRET_KEY must be set in production.")

ALLOWED_HOSTS = [
    host.strip()
    for host in os.environ.get("DJANGO_ALLOWED_HOSTS", "").split(",")
    if host.strip()
]
if not ALLOWED_HOSTS:
    raise ImproperlyConfigured("DJANGO_ALLOWED_HOSTS must list allowed hostnames.")

INSTALLED_APPS = [app for app in INSTALLED_APPS if app != "debug_toolbar"]
MIDDLEWARE = [
    middleware
    for middleware in MIDDLEWARE
    if middleware != "debug_toolbar.middleware.DebugToolbarMiddleware"
]

STATIC_ROOT = os.environ.get("STATIC_ROOT", "/app/staticfiles")
MEDIA_ROOT = os.environ.get("MEDIA_ROOT", "/app/media")

CSRF_COOKIE_SECURE = bool(int(os.environ.get("CSRF_COOKIE_SECURE", "1")))
SESSION_COOKIE_SECURE = bool(int(os.environ.get("SESSION_COOKIE_SECURE", "1")))
SECURE_SSL_REDIRECT = bool(int(os.environ.get("SECURE_SSL_REDIRECT", "1")))
SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")

if os.environ.get("DJANGO_SECURE_HSTS_SECONDS"):
    SECURE_HSTS_SECONDS = int(os.environ["DJANGO_SECURE_HSTS_SECONDS"])
    SECURE_HSTS_INCLUDE_SUBDOMAINS = bool(
        int(os.environ.get("DJANGO_SECURE_HSTS_INCLUDE_SUBDOMAINS", "1"))
    )
    SECURE_HSTS_PRELOAD = bool(int(os.environ.get("DJANGO_SECURE_HSTS_PRELOAD", "0")))
