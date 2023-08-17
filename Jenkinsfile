node {
    stage('Build') {
        docker.image('python:2-alpine').inside {
            checkout scm
            sh 'python -m py_compile sources/add2vals.py sources/calc.py'
            stash name: 'compiled-results', includes: 'sources/*.py*'
        }
    }
    
    stage('Test') {
        docker.image('qnib/pytest').inside {
            sh 'py.test --junit-xml test-reports/results.xml sources/test_calc.py'
            junit 'test-reports/results.xml'
        }
    }
    
    stage('Deliver') {
        docker.image('cdrx/pyinstaller-linux:python2').inside {
            try {
                sh "pyinstaller --onefile sources/add2vals.py'"
            } finally {
                archiveArtifacts artifacts: "dist/add2vals", allowEmptyArchive: true
            }
        }
    }

    stage('Deploy') {
        docker.image('ubuntu:latest').inside {
            sh "scp dist/add2vals root@ec2-3-24-240-109.ap-southeast-2.compute.amazonaws.com:/var/www/html"
        }
    }
}
