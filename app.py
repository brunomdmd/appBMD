from flask import Flask
import boto3

app = Flask(__name__)

@app.route('/')
def home():
    task_ids = get_task_ids()
    replicas_count = get_replicas_count()
    return (f'<h1>Teste DevOps | Bruno Martins Damasceno!</h1>'
            f'<p>Número de réplicas em execução: {replicas_count}</p>'
            f'<p>IDs das tarefas: {", ".join(task_ids)}</p>')

def get_replicas_count():
    ecs_client = boto3.client('ecs', region_name='us-east-1')

    cluster_name = 'PRD-GENERAL'
    service_name = 'PRD-BMD'

    try:
        response = ecs_client.describe_services(
            cluster=cluster_name,
            services=[service_name]
        )
        if response['services']:
            return response['services'][0].get('runningCount', 0)
        else:
            return 0
    except Exception as e:
        return f"Erro ao obter o número de réplicas: {e}"

def get_task_ids():
    ecs_client = boto3.client('ecs', region_name='us-east-1')

    cluster_name = 'PRD-GENERAL'
    service_name = 'PRD-BMD'

    try:
        response = ecs_client.list_tasks(
            cluster=cluster_name,
            serviceName=service_name,
            desiredStatus='RUNNING'
        )
        task_ids = response['taskArns']
        return [task.split('/')[-1] for task in task_ids]
    except Exception as e:
        return [f"Erro ao obter os IDs das tarefas: {e}"]

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)