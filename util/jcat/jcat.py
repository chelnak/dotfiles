from rich.console import Console
from rich.syntax import Syntax
import json
import argparse
from json import JSONDecodeError

parser = argparse.ArgumentParser()
parser.add_argument('filename', help='Path to the file that will be loaded')
args = parser.parse_args()

try:
    console = Console()

    with open(args.filename, 'r') as file:
        data = file.read()
        valid = json.loads(data)
        syntax = Syntax(data, 'json', theme='monokai', line_numbers=True)
        console.print(syntax)

except FileNotFoundError:
        print('Could not find specified file: {0}'.format(args.filename))

except JSONDecodeError as json_error:
    print('Failed to decode json file!')
    print('Error message: {0}'.format(json_error))

except Exception as e:
    raise e

