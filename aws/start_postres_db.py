import boto3
import os
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def start_rds_all():
    key = os.environ['KEY']
    value = os.environ['VALUE']
    client = boto3.client('rds')
    response = client.describe_db_instances()

    v_readReplica = []
    for i in response['DBInstances']:
        readReplica = i['ReadReplicaDBInstanceIdentifiers']
        v_readReplica.extend(readReplica)

    for i in response['DBInstances']:

        if i['Engine'] not in ['aurora-mysql', 'aurora-postgresql']:

            if i['DBInstanceIdentifier'] not in v_readReplica and len(i['ReadReplicaDBInstanceIdentifiers']) == 0:
                arn = i['DBInstanceArn']
                aws_edu_rds = client.list_tags_for_resource(ResourceName=arn)

                if len(aws_edu_rds['TagList']) == 0:
                    logger.info('DB Instance {0} is not part of auto-startup'.format(i['DBInstanceIdentifier']))
                else:
                    for tag in aws_edu_rds['TagList']:
                        if tag['Key'] == key and tag['Value'] == value:
                            if i['DBInstanceStatus'] == 'available':
                                logger.info('{0} DB instance is already available'.format(i['DBInstanceIdentifier']))
                            elif i['DBInstanceStatus'] == 'stopped':
                                client.start_db_instance(DBInstanceIdentifier=i['DBInstanceIdentifier'])
                                logger.info('Started DB Instance {0}'.format(i['DBInstanceIdentifier']))
                            elif i['DBInstanceStatus'] == 'starting':
                                logger.info(
                                    'DB Instance {0} is already in starting state'.format(i['DBInstanceIdentifier']))
                            elif i['DBInstanceStatus'] == 'stopping':
                                logger.info('DB Instance {0} is in stopping state. Please wait before starting'.format(
                                    i['DBInstanceIdentifier']))
                        elif tag['Key'] != key and tag['Value'] != value:
                            logger.info('DB instance {0} is not part of auto-startup'.format(i['DBInstanceIdentifier']))
                        elif len(tag['Key']) == 0 or len(tag['Value']) == 0:
                            logger.info('DB Instance {0} is not part of auto-startup'.format(i['DBInstanceIdentifier']))
            elif i['DBInstanceIdentifier'] in v_readReplica:
                logger.info('DB Instance {0} is a Read Replica.'.format(i['DBInstanceIdentifier']))
            else:
                logger.info(
                    'DB Instance {0} has a read replica. Cannot shutdown & start a database with Read Replica'.format(
                        i['DBInstanceIdentifier']))


def lambda_handler(event, context):
    start_rds_all()
