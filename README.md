// BAD PRACTICE
const express = require('express');
const mysql = require('mysql2');
const app = express();

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'test'
});

app.get('/user', (req, res) => {
  const userId = req.query.id;
  const query = `SELECT * FROM users WHERE id = ${userId}`; // Vulnerable!
  connection.query(query, (err, results) => {
    if (err) throw err;
    res.send(results);
  });
});

app.listen(3000);




                    // Timeout de 30 segundos
                    timeout(time: 30, unit: 'SECONDS') {
                        echo "Opción seleccionada: ${userChoice}"
                    }
currentBuild.result = 'ABORTED'




pipeline {
    agent any

    stages {
        stage('Seleccionar opción') {
            steps {
                script {
                    try {
                        // Timeout aplica al input, no al echo
                        def userChoice = timeout(time: 30, unit: 'SECONDS') {
                            input(
                                id: 'userInput', 
                                message: 'Escoge una opción', 
                                parameters: [
                                    [$class: 'ChoiceParameterDefinition',
                                     choices: "Opción 1\nOpción 2\nTerminar",
                                     name: 'OPCION']
                                ]
                            )
                        }
                        echo "Opción seleccionada: ${userChoice}"
                    } catch(err) {
                        // Timeout o cancelación
                        echo "No se seleccionó opción a tiempo. Se ejecuta Opción 1 por defecto."
                        userChoice = 'Opción 1'
                    }

                    // Ejecutar según opción
                    if (userChoice == 'Opción 1') {
                        echo "Ejecutando opción 1"
                    } else if (userChoice == 'Opción 2') {
                        echo "Ejecutando opción 2"
                    } else if (userChoice == 'Terminar') {
                        echo "Terminando job"
                        currentBuild.result = 'ABORTED'
                        error('Job terminado por opción seleccionada')
                    }
                }
            }
        }
    }
}










AWSTemplateFormatVersion: "2010-09-09"
Description: ECS Fargate con AutoScaling dinámico (versión minimalista)

Parameters:
  VpcSubnets:
    Type: List<AWS::EC2::Subnet::Id>
    Description: Subnets donde se desplegará el servicio ECS
  SecurityGroups:
    Type: List<AWS::EC2::SecurityGroup::Id>
    Description: Security groups para el servicio ECS

Resources:
  #######################################
  # ECS Cluster
  #######################################
  ECSCluster:
    Type: AWS::ECS::Cluster

  #######################################
  # Task Definition
  #######################################
  TaskDefinition:
    Type: AWS::ECS::TaskDefinition
    Properties:
      Family: nginx-fargate-task
      Cpu: "256"
      Memory: "512"
      NetworkMode: awsvpc
      RequiresCompatibilities:
        - FARGATE
      ExecutionRoleArn: !GetAtt TaskExecutionRole.Arn
      ContainerDefinitions:
        - Name: nginx
          Image: nginx:latest
          PortMappings:
            - ContainerPort: 80
              Protocol: tcp

  TaskExecutionRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: "2012-10-17"
        Statement:
          - Effect: Allow
            Principal:
              Service: ecs-tasks.amazonaws.com
            Action: sts:AssumeRole
      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy

  #######################################
  # ECS Service
  #######################################
  ECSService:
    Type: AWS::ECS::Service
    Properties:
      Cluster: !Ref ECSCluster
      DesiredCount: 1
      LaunchType: FARGATE
      TaskDefinition: !Ref TaskDefinition
      NetworkConfiguration:
        AwsvpcConfiguration:
          AssignPublicIp: ENABLED
          Subnets: !Ref VpcSubnets
          SecurityGroups: !Ref SecurityGroups
      DeploymentConfiguration:
        MaximumPercent: 200
        MinimumHealthyPercent: 50

  #######################################
  # AutoScaling
  #######################################
  ApplicationAutoScalingRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: "2012-10-17"
        Statement:
          - Effect: Allow
            Principal:
              Service: application-autoscaling.amazonaws.com
            Action: sts:AssumeRole
      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole

  ECSServiceScalableTarget:
    Type: AWS::ApplicationAutoScaling::ScalableTarget
    Properties:
      MaxCapacity: 5     # máximo de tareas
      MinCapacity: 1     # mínimo de tareas
      ResourceId: !Sub service/${ECSCluster}/${ECSService}
      RoleARN: !GetAtt ApplicationAutoScalingRole.Arn
      ScalableDimension: ecs:service:DesiredCount
      ServiceNamespace: ecs

  ECSServiceScalingPolicyCPU:
    Type: AWS::ApplicationAutoScaling::ScalingPolicy
    Properties:
      PolicyName: ecs-service-cpu-scaling
      PolicyType: TargetTrackingScaling
      ScalingTargetId: !Ref ECSServiceScalableTarget
      TargetTrackingScalingPolicyConfiguration:
        TargetValue: 90.0
        PredefinedMetricSpecification:
          PredefinedMetricType: ECSServiceAverageCPUUtilization
        ScaleInCooldown: 60
        ScaleOutCooldown: 60

  ECSServiceScalingPolicyMemory:
    Type: AWS::ApplicationAutoScaling::ScalingPolicy
    Properties:
      PolicyName: ecs-service-memory-scaling
      PolicyType: TargetTrackingScaling
      ScalingTargetId: !Ref ECSServiceScalableTarget
      TargetTrackin

