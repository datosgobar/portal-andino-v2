import click


@click.group(short_help="gobar_harvest CLI.")
def gobar_harvest():
    """gobar_harvest CLI.
    """
    pass


@gobar_harvest.command()
@click.argument("name", default="gobar_harvest")
def command(name):
    """Docs.
    """
    click.echo("Hello, {name}!".format(name=name))


def get_commands():
    return [gobar_harvest]
