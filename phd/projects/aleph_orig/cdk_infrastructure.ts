// Prerequisites:

//     AWS CLI installed and configured
//     Node.js and npm installed
//     AWS CDK installed (npm install -g aws-cdk)

import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as rds from 'aws-cdk-lib/aws-rds';
import * as ssm from 'aws-cdk-lib/aws-ssm';

export class AlephProtocolStack extends cdk.Stack {
    constructor(scope: Construct, id: string, props?: cdk.StackProps) {
        super(scope, id, props);

        const vpc = new ec2.Vpc(this, 'AlephVpc', {
            maxAzs: 2,
            natGateways: 1,
        });

        const dbInstance = new rds.DatabaseInstance(this, 'AlephPostgres', {
            engine: rds.DatabaseInstanceEngine.postgres({
                version: rds.PostgresEngineVersion.VER_13_3,
            }),
            instanceType: ec2.InstanceType.of(ec2.InstanceClass.BURSTABLE2, ec2.InstanceSize.MICRO),
            vpc,
            multiAz: false,
            allocatedStorage: 20,
            storageType: rds.StorageType.GP2,
            publiclyAccessible: false,
            credentials: rds.Credentials.fromGeneratedSecret('postgres'),
        });

        new ssm.StringParameter(this, 'DbEndpoint', {
            parameterName: '/aleph-protocol/db-endpoint',
            stringValue: dbInstance.instanceEndpoint.socketAddress,
        });
    }
}

const app = new cdk.App();
new AlephProtocolStack(app, 'AlephProtocolStack');
