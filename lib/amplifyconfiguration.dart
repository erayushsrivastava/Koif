const amplifyconfig = '''{
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-west-3_ywcmLAWkL", 
                        "AppClientId": "2hpinks2hgdcmcai3ldnq1m3e1",
                        "Region": "eu-west-3"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "eu-west-3ywcmlawkl.auth.eu-west-3.amazoncognito.com", 
                            "AppClientId": "2hpinks2hgdcmcai3ldnq1m3e1",
                            "SignInRedirectURI": "myapp://callback/",
                            "SignOutRedirectURI": "myapp://signout/",
                            "Scopes": [
                                "email",
                                "openid",
                                "profile"
                            ]
                        }
                    }
                }
            }
        }
    }
}''';
