 pipeline
{
    agent any
        stages
        {
            stage('continuous download')
            {
                steps
                {
                    git credentialsId: 'bitbucket', url: 'https://vivekg141@bitbucket.org/vivekg141/multibranch_pipeline.git'
                }
            }
        }
} 