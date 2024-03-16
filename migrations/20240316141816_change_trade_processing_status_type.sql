CREATE TYPE processing_status_enum AS ENUM ('STARTED', 'SUCCESS', 'FAILED');

ALTER TABLE trade_processing_statuses
ALTER COLUMN processing_status TYPE processing_status_enum
USING processing_status::processing_status_enum;
