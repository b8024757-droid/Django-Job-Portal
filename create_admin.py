import os
import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "jobs.settings")
django.setup()

from django.contrib.auth import get_user_model

User = get_user_model()

email = "admin@hiremind.ai"
password = "YourStrongPassword123"

if not User.objects.filter(email=email).exists():
    User.objects.create_superuser(
        email=email,
        password=password,
        role="admin"
    )
    print("✅ Superuser created!")
else:
    print("ℹ️ Superuser already exists.")
