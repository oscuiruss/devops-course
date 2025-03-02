import random
import string
from .models import ShortenedURL


def generate_short_code(length: int = 6) -> str:
    valid_chars: str = string.ascii_letters + string.digits

    n: int = len(valid_chars)
    remaining_attempts: int = n ** length  # Maximum number of codes possible with given length
    while remaining_attempts > 0:
        code: str = "".join(random.choices(valid_chars, k=length))

        if not ShortenedURL.query.filter_by(code=code).first():
            return code

        remaining_attempts -= 1

    # Try again with a longer code
    return generate_short_code(length + 1)
