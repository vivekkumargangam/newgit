pipeline
{
    agent any
        stages
        {
            stage('continuous download')
            {
                steps
                {
                    
                }
            }
            stage('copying the file to root directory')
            {
                steps
                {
                    sh 'sudo -S cp -r /var/lib/jenkins/workspace/pipeline/ /root'
                }
            }
            stage('bulding the docker image')
            {
                steps
                {
                    sh 'sudo -S docker build -t jalm-2.4.3 -f Dockerfile /root//'
                }
            }
            stage('bulding the docker container')
            {
                steps
                {
                    script
                    {
                     try
                     
                     {
                         sh 'sudo -S docker run --name ja-2.4.3 -itd jalm-2.4.3'
                     }
                     catch(Exception e1)
                     {
                        input message: 'remove the container', submitter: 'srikanth'
                        sh 'sudo -S docker rm -f ja1'
                        sh 'sudo -S docker run --name ja-2.4.3 -itd jalm-2.4.3'
                     }
                    }
                }    
            }
            
        }
}