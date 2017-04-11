manager.buildUnstable();
// explicitly set build result
manager.build.@result = hudson.model.Result.UNSTABLE

job('imagebuild') {
    description('Build Application Image')
    logRotator(3,3)
    parameters {
        stringParam('GIT_REPOSITORY_URI')
        stringParam('GIT_REPOSITORY_BRANCH')
        stringParam('DOCKER_IMAGE_POOL')
        stringParam('DOCKER_IMAGE_NAME_PREFIX')
        stringParam('DOCKER_IMAGE_TAG')
        stringParam('ORO_ROOT_IMAGE')
        stringParam('BUILD_OPTIONS_ENVIRONMENT')
        stringParam('RSA_KEY_FINGERPRINT')
        stringParam('VAULT_ADDR')
        stringParam('BUILDER_IMAGE')
        stringParam('ORO_IMAGE_ID')
        stringParam('OWNER_USERNAME')
        stringParam('OWNER_APIKEY')
        stringParam('MGMT_URL')
    }
    concurrentBuild()

    wrappers {
        timeout {
            noActivity(300)
            failBuild()
        }
        timestamps()
    }




    steps {
        shell(readFileFromWorkspace('jobs/imagebuild/build/run.sh'))


        conditionalSteps {
            condition {
                status('SUCCESS', 'SUCCESS')
            }
            runner('Run')
            steps {
                shell(readFileFromWorkspace('jobs/imagebuild/build/conditions/success.sh'))
            }
        }

        conditionalSteps {
            condition {
               and {
                    status('ABORTED', 'UNSTABLE')
               }
            }
            runner('Unstable')
            steps {
                shell(readFileFromWorkspace('jobs/imagebuild/build/conditions/failed.sh'))
            }
        }
    }
}
