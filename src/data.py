# -*- coding: utf-8 -*-


def get_env_variable(env, env_variable):
    a = {
        'BUHETLA2': {
            'login': u'Главный бухгалтер',
            'password': '',
        },
        'MBTEST_ALL': {
            'login': u'Адміністратор',
            'password': '',
        },
        'MBDEMO_ALL': {
            'login': u'Головний бухгалтер',
            'password': '',
        },
    }
    if env not in a:
        return env
    else:
        return a[env][env_variable]

