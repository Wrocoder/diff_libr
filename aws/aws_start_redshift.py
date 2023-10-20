import datetime
import logging
import os

import boto3
from botocore.exceptions import ClientError

# Configure the logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def start_cluster(cluster_id):
    client = boto3.client('redshift')
    paginator = client.get_paginator('describe_clusters')
    pages = paginator.paginate()

    for page in pages:
        for cluster in page['Clusters']:
            try:
                if cluster_id == cluster['ClusterIdentifier']:
                    client.resume_cluster(ClusterIdentifier=cluster['ClusterIdentifier'])
                    logger.info(f'{cluster["ClusterIdentifier"]} is resuming')
                    return  # No need to continue checking other clusters
            except ClientError as e:
                logger.error(f'Cluster status is {cluster["ClusterStatus"]}')
                logger.error(f'ERROR: {e}')

    logger.warning(f'No clusters with {cluster_id} found')


def check_for_available_time():
    utc_ts = datetime.datetime.utcnow()
    utc_hour = str(utc_ts.hour)
    iso_weekday = str(utc_ts.isoweekday())

    available_hours = os.environ.get('AVAILABLE_HOURS').split(',')
    available_days = os.environ.get('AVAILABLE_DAYS').split(',')

    return utc_hour in available_hours and iso_weekday in available_days


def lambda_handler(event, context):
    cluster_id = os.environ.get('CLUSTER_ID')

    if check_for_available_time():
        start_cluster(cluster_id)
    else:
        logger.info('The cluster is available timezone')
