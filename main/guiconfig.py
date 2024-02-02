import json


class GUIConfig:

    def __init__(self):
        pass   
     
    def update():
        with open('./usr_config/config.json', 'r') as json_file:
            json_content = json_file.read()

        with open('./main/web/rep_template/usr_config_tmp.html', 'r') as html_file:
            html_content = html_file.read()

        html_content = html_content.replace('<!-- __config__ -->', json_content)

        with open('./usr_config/usr_config.html', 'w') as html_file:
            html_file.write(html_content)
    pass
