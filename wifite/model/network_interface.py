class NetworkInterface:
    def __init__(self, name, role):
        self.name = str(name)
        self.role = role

    def __str__(self):
        return "{0} ({1})".format(self.name, self.role)