import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { UserEntity } from "./user.entity";

@Entity("post")
export class PostEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    post_id!: string;

    @Column({
        nullable: false,
    })
    post_title!: string;

    @Column({
        nullable: false,
    })
    post_text!: string;

    @Column({
        type: "simple-array",
        nullable: false,
    })
    post_images!: string[];

    @Column({
        nullable: false,
        type: "timestamp",
        default: () => "CURRENT_TIMESTAMP(6)",

    })
    post_time!: Date;

    @Column({
        nullable: true,
        type: "simple-array"
    })
    post_comments?: string[];

    @Column({
        default: 0,
    })
    post_likes?: number;

    @ManyToOne(() => UserEntity, post_user => post_user.userposts)
    post_user!: UserEntity;
}