import { BaseEntity, Column, Entity, JoinColumn, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { IsEmail } from "class-validator";
import { PostEntity } from "./post.entity";

@Entity("users")
export class UserEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    id!: string;

    @Column({
        nullable: false
    })
    username!: string;

    @Column({
        nullable: false
    })
    @IsEmail({}, { message: 'Enter a valid email', groups: ['email'] })
    useremail!: string;

    @Column({
        nullable: false
    })
    userpassword!: string;
    @Column({
        nullable: true
    })
    userimage!: string;

    @OneToMany(() => PostEntity, userposts => userposts.post_user)
    //@JoinColumn()
    userposts!: PostEntity[];

}