FactoryGirl.define do
  factory :activation do
    association :repository, strategy: :build
    deploy_key_id 13578126
    webhook_id 5787231
    provider Provider[:github]

    public_key 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCofqDGRd4ZdlUUppC6943LJGwK1cc'\
               'j1lr0b+ovoaPjtb2BBydBIGpK5jSF6vXCo38mOKJNFdmJsLM9FwW5uqF3dDj5co4LbrL'\
               'J4JjC6MlKWfX3hlffOL4QcPYGb1O/4RyJPyFyuHAclvy2E1KIhJbShjtwt5QtIUkNy0Q'\
               'bVgTw6jARL0cOKXmVQJjMbXtSxXCvEd6e3HM+GJn2uhLCZLH4EYaw8BysB9yseM5p9NJ'\
               'mkK6x0kkylTBWQWBWlAg5ZUGButrTZ42cT6aP9OopR0qFJgYFXu75oueo/11L3yyutgg'\
               'Ci5j4rpqPCgXqE5npl/vOTA5q/2oPw5dxZt4cwXP LintCI'
    private_key "-----BEGIN RSA PRIVATE KEY-----\n"\
                "MIIEpAIBAAKCAQEAwqH6gxkXeGXZVFKaQuveNyyRsCtXHI9Za9G/qL6Gj47W9gQc\n"\
                "nQSBqSuY0her1wqN/JjiiTRXZibCzPRcFubqhd3Q4+XKOC26yyeCYwujJSln194Z\n"\
                "X3zi+EHD2Bm9Tv+EciT8hcrhwHJb8thNSiISW0oY7cLeULSFJDctEG1YE8OowES9\n"\
                "HDil5lUCYzG17UsVwrxHentxzPhiZ9roSwmSx+BGGsPAcrAfcrHjOafTSZpCusdJ\n"\
                "JMpUwVkFgVpQIOWVBgbra02eNnE+mj/TqKUdKhSYGBV7u+aLnqP9dS98srrYIAou\n"\
                "Y+K6ajwoF6hOZ6Zf7zkwOav9qD8OXcWbeHMFzwIDAQABAoIBADYtprFFk8308/lQ\n"\
                "ARbt126eXnOerOILWUX1HhfX6Vce2OGkpV5j+b/gneqlojT7ACk3WZ/9zPJnicRJ\n"\
                "pTTO1Kus4k/+EDtxJ1UTy2zMuX5Ht1tUvNViyz919xE5oQPThsfLWevYXN0YOFYy\n"\
                "NdmUAG4fAy90FjR6+7DoFwhCl8jwKq83G8OzbOrahCEmLMlCnKEV8deZyMCKQQdJ\n"\
                "h11K6Xm3cXOGWr5doHQaQzs/jMgLFq2BT/9HI9u68UpVHhf+/7maEteWWkqWI/XH\n"\
                "E9hO+Okx/XK/QCc37fp5rYyK9DLp5qvKABc9TymZuyBavev/OZVd3rEU70nt4GRw\n"\
                "ocE5ggkCgYEA6QX0u9sVAvZsKStBcQEoPVmV7QDgQxgZ0HQ+Nt/VxPVJ8p/NxxRw\n"\
                "AB2egeQaSo63u6Gr4p6ff7WilgZG1pmCSW6H+pS8bic7Hfn6AjemaQDPhXesSDj1\n"\
                "ZPOG0QPy7GwtkLZKedT6JinDqpLEBCwu617NHMl8lIq+2IpVVd4IKBsCgYEA1dL0\n"\
                "/RNKnGFCoWabeFUYgTcdamFrPdRNgVt1+0MCM40rDqLNeML8kjVdmEsdlIX0flyB\n"\
                "sUEfxcB4v0DVlYz8U5/HLOAJWiUDJxioz4cLAeaEa/aFMrDl76PkU5OftXNF3zla\n"\
                "uiPRmhALh5RUZNsr79HdXJsWsZUZkesq603knF0CgYBg0aaz/v0l8/lQybYxG8f6\n"\
                "ZaSTis+jUPo40HOhHTOW2EvXUWqQkv9OLQBU+8+ots/EWBIw4LNovrFFIGqCc9nc\n"\
                "ZN5+0RnRst8vP1QPY8vyyPFwhR7CC1h6j2yun7NpZDEydWtQX5toC+ZOkxh6m1kL\n"\
                "VqJmmZj3pwZQtnlqagx9jQKBgQC1ikhKXgiowMLrecxh3A3UF1E4MsH0Wr37KAYB\n"\
                "cCD8V8zIvlypPRNnpztxw8S3hwvQBQZv0hUBtqpN5uPv9yV8clmOth/6kxYcKYmZ\n"\
                "uNQVpvujFkh8g0iVr5Z5hwq/6cDXB0EKbMLWhOzlDYChqJujH5FLwLkByM9O3lUw\n"\
                "No/0WQKBgQCVjmOqDZ5orh1GvWI/JiR06pxKaPHx3NSlaMSbuqjekOkG2CCCt+6E\n"\
                "IrijflTdimvis14jFordpLFrbywbG3Pagi4egp5YpPalOcwdcW4OJPA/5dsQkeHy\n"\
                "z1ec5+ja4Wfm4iZmdGCvjeb4dguIkWh0q7obKugs4n1xjUpJuiXzWg==\n"\
                "-----END RSA PRIVATE KEY-----\n"
  end
end
