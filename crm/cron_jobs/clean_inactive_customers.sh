#!/bin/bash

# Activate virtual environment if needed
# source /path/to/venv/bin/activate

# Set project directory
PROJECT_DIR="/absolute/path/to/your/project"
cd "$PROJECT_DIR"

# Run Django cleanup logic using manage.py shell
DELETED_COUNT=$(python3 manage.py shell << END
from crm.models import Customer
from django.utils import timezone
from datetime import timedelta

cutoff_date = timezone.now() - timedelta(days=365)
deleted, _ = Customer.objects.filter(last_order_date__lt=cutoff_date).delete()
print(deleted)
END
)

# Log to file with timestamp
echo "$(date): Deleted $DELETED_COUNT inactive customers" >> /tmp/customer_cleanup_log.txt
