# Global Coding Instructions

## General

- Write clean, readable, maintainable code.
- Follow the conventions and architecture already present in the project.
- Prefer simple solutions over unnecessary abstractions.
- Do not change unrelated code.
- Explain important trade-offs when making non-obvious decisions.

## Python Style

- Follow PEP 8.
- Use exactly 2 spaces for indentation. Never use tabs.
- Use snake_case for variables and functions.
- Use PascalCase for classes.
- Use UPPER_SNAKE_CASE for constants.
- Add type hints to function parameters and return values.
- Write docstrings for public functions and classes when useful.
- Prefer pathlib over os.path for filesystem operations.
- Use context managers (with) for files and resources.
- Avoid wildcard imports.
- Use f-strings for string formatting.
- Handle exceptions explicitly; do not silently swallow errors.
- Use `| None` instead of `Optional` for type hints.
- Avoid unnecessary comments; don't add comments to every method or function if the name already explains what it does.
- Avoid unnecessary comments that merely repeat the code.
- User updates should be prioritized; never restore a file that the user has updated, always increment/update from the user's version.
- Use Pydantic `BaseModel` for FastAPI request bodies; FastAPI auto-generates Swagger/OpenAPI documentation from the model.
- Use `Header(alias=NAME)` pattern for header validation; define the header name as a constant for consistency.
- Use 1 blank line after imports and variable declarations.
- Use 1 blank line between methods within a class; use 2 blank lines after top-level function and class definitions.
- Keep method bodies on a single line when they consist of a simple return or statement.
