from airflow.providers.docker.operators.docker import DockerOperator
from airflow import DAG
from datetime import datetime
from docker.types import Mount


dag = DAG('create_layers_in_snowflake',start_date=datetime.now(), schedule_interval=None,catchup=False)

run_dbt_task = DockerOperator(
    task_id='create_seeds',
    image='custom_dbt_image',
    api_version='auto',
    docker_url='unix://var/run/docker.sock', 
    command='sh -c "cd /dbtlearn && dbt seed --project-dir /dbtlearn"',
    mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbtlearn',target='/dbtlearn',type='bind')],
    network_mode='container:dbt',  
    dag=dag
)


run_dbt_task_1 = DockerOperator(
    task_id='create_target_layer',
    image='custom_dbt_image',
    api_version='auto',
    docker_url='unix://var/run/docker.sock', 
    command='sh -c "cd /dbtlearn && dbt run --models target_layer.* --project-dir /dbtlearn"',
    mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbtlearn',target='/dbtlearn',type='bind')],
    network_mode='container:dbt',  
    dag=dag
)


run_dbt_task_2 = DockerOperator(
    task_id='create_business_layer',
    image='custom_dbt_image',
    api_version='auto',
    docker_url='unix://var/run/docker.sock', 
    command='sh -c "cd /dbtlearn && dbt run --models business_layer.* --project-dir /dbtlearn"',
    mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbtlearn',target='/dbtlearn',type='bind')],
    network_mode='container:dbt',  
    dag=dag
)

run_dbt_task_3 = DockerOperator(
    task_id='create_mart_full_moon',
    image='custom_dbt_image',
    api_version='auto',
    docker_url='unix://var/run/docker.sock', 
    command='sh -c "cd /dbtlearn && dbt run --models mart_full_moon_reviews.* --project-dir /dbtlearn"',
    mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbtlearn',target='/dbtlearn',type='bind')],
    network_mode='container:dbt',  
    dag=dag
)

run_dbt_task_4 = DockerOperator(
    task_id='create_mart_review_score',
    image='custom_dbt_image',
    api_version='auto',
    docker_url='unix://var/run/docker.sock', 
    command='sh -c "cd /dbtlearn && dbt run --models mart_review_score.* --project-dir /dbtlearn"',
    mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbtlearnn',target='/dbtlearn',type='bind')],
    network_mode='container:dbt',  
    dag=dag
)

run_dbt_task_5 = DockerOperator(
    task_id='create_lineage_graph',
    image='custom_dbt_image',
    api_version='auto',
    docker_url='unix://var/run/docker.sock', 
    command='sh -c "cd /dbtlearn && dbt docs generate && dbt docs serve --port 8085"',
    mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbtlearn',target='/dbtlearn',type='bind')],
    network_mode='container:dbt',  
    dag=dag
)



run_dbt_task >> run_dbt_task_1 >> run_dbt_task_2 >> [run_dbt_task_3,run_dbt_task_4] >> run_dbt_task_5
